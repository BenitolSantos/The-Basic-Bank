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
    redirect_if_not_your_transaction
    erb :'/transactions/show'
  end


  post '/transactions' do
    redirect_if_not_logged_in
    @transaction = Transaction.new(amount: params["transaction"]["amount"], user_id: current_user.id)
    #ActiveRecord::SubclassNotFound: Invalid single-table inheritance type: deposit is not a subclass of Transaction
    if params["version"] == "deposit"
      @transaction.update(version: "deposit")
      current_user.balance += params["transaction"]["amount"].to_i
      current_user.transactions << @transaction
      current_user.save
    elsif params["version"] == "withdrawl"
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
    redirect_if_not_your_transaction
    #this resets the balance to before the previous edit
    #move line 46 to 56 to patch and delete just incase they hit the edit page twice
    erb :"/transactions/edit"
  end

  patch '/transactions/:id' do
    redirect_if_not_logged_in
    redirect_if_not_your_transaction #new helper
    if @transaction.version == "deposit"
      current_user.balance -= @transaction.amount.to_i
      current_user.save
    elsif @transaction.version == "withdrawl"
      current_user.balance += @transaction.amount.to_i
      current_user.save
    else
    end

    if !(params["transaction"]["amount"].empty?)
      if params["version"] == "deposit"
        @transaction.update(version: "deposit", amount: params["transaction"]["amount"])
        current_user.balance += @transaction.amount.to_i
        @transaction.save
        current_user.save
      elsif params["version"] == "withdrawl"
        @transaction.update(version: "withdrawl", amount: params["transaction"]["amount"])
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
    redirect_if_not_your_transaction
    #transaction flash message for people trying to access other transactions
    @user = @transaction.user
    if @transaction.version == "deposit"
      current_user.balance -= @transaction.amount.to_i
      current_user.save
    elsif @transaction.version == "withdrawl"
      current_user.balance += @transaction.amount.to_i
      current_user.save
    else
    end
    #applies the ActiveRecord relationship
    @user.transactions.delete(@transaction)
    Transaction.all.delete(@transaction)
    redirect to ("/transactions")
  end



end
