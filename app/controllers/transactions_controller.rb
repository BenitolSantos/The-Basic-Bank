class TransactionsController < ApplicationController
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }
  register Sinatra::Flash
  get '/transactions' do
    redirect_if_not_logged_in
    @transactions = current_user.transactions
    erb :'/transactions/index'
  end

  get '/transactions/new' do
    redirect_if_not_logged_in
    erb :'/transactions/new'
  end


  get '/transactions/:id' do
    redirect_if_not_logged_in
    @transaction = Transaction.find_by_id(params[:id])
    erb :'/transactions/show'
  end


  post '/transactions' do
    redirect_if_not_logged_in
    @transaction = Transaction.new(amount: params["transaction"]["amount"], user_id: current_user.id)
    #ActiveRecord::SubclassNotFound: Invalid single-table inheritance type: deposit is not a subclass of Transaction
    if params["deposit"] == "on"
      @transaction.update(version: "deposit")
      current_user.balance += params["transaction"]["amount"].to_i
      current_user.transactions << @transaction
      current_user.save
    elsif params["withdrawl"] == "on"
      @transaction.update(version: "withdrawl")
      current_user.balance -= params["transaction"]["amount"].to_i
      current_user.transactions << @transaction
      current_user.save
    else
    end
      redirect to "/transactions"
  end


  get '/transactions/:id/edit' do
    redirect_if_not_logged_in
    @transaction = current_user.transactions.find_by(id: params[:id])
    if @transaction == nil
      flash[:message] = "Thats not your transaction."
      redirect to("/transactions")
    end
    #this resets the balance to before the previous edit
    #move line 46 to 56 to patch and delete just incase they hit the edit page twice
    erb :"/transactions/edit"
  end

  patch '/transactions/:id' do
    redirect_if_not_logged_in
    @transaction = current_user.transactions.find_by(id: params[:id])
    if @transaction.version == "deposit"
      @transaction.update(version: "deposit")
      current_user.balance -= @transaction.amount.to_i
      current_user.save
    elsif @transaction.version == "withdrawl"
      current_user.balance += @transaction.amount.to_i
      current_user.save
    else
    end

    if !(params["transaction"]["amount"].empty?)
      if params["deposit"] == "deposit"
        @transaction.update(version: "deposit", amount: params["transaction"]["amount"])
        current_user.balance += @transaction.amount.to_i
        @transaction.save
        current_user.save
      elsif params["withdrawl"] == "withdrawl"
        @transaction.update(version: "deposit", amount: params["transaction"]["amount"])
        current_user.balance -= @transaction.amount.to_i
        @transaction.save
        current_user.save
      else
      end
      redirect to ("/transactions/#{@transaction.id}")
    else
      redirect to ("/transactions/#{@transaction.id}/edit")
    end
  end

  delete '/transactions/:id' do
    redirect_if_not_logged_in
    @transaction = current_user.transactions.find_by(id: params[:id])
    @user = @transaction.user
    if @transaction.version == "deposit"
      @transaction.update(version: "deposit")
      current_user.balance -= @transaction.amount.to_i
      current_user.save
    elsif @transaction.version == "withdrawl"
      current_user.balance += @transaction.amount.to_i
      current_user.save
    else
    end
    #applies the ActiveRecord relationship
    if current_user == @user
      @user.transactions.delete(@transaction)
      Transaction.all.delete(@transaction)
    end
    redirect to ("/transactions")
  end



end
