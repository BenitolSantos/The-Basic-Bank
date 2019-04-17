class TransactionsController < ApplicationController
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/transactions' do
    redirect_if_not_logged_in
    binding.pry
    #problem here... current_user.transactions isn't nil or filled
    # [4] pry(#<TransactionsController>)> current_user.transactions
    #D, [2019-04-17T18:40:42.848086 #774] DEBUG -- :   Transaction Load (0.1ms)  SELECT "transactions".* FROM "transactions" WHERE "transactions"."user_id
    #" = ?  [["user_id", 1]]
    #D, [2019-04-17T18:40:42.848875 #774] DEBUG -- :   Transaction Load (0.1ms)  SELECT "transactions".* FROM "transactions" WHERE "transactions"."user_id
    #" = ?  [["user_id", 1]]
    if current_user.transactions != []
    @transactions = current_user.transactions
    else
    @transactions = []
    end
    erb :'/transactions/index'
  end

  get '/transactions/new' do
    redirect_if_not_logged_in
    erb :'/transactions/new'
  end


  get '/transactions/:id' do
    redirect_if_not_logged_in
  end


  post '/transactions' do
    redirect_if_not_logged_in
    @transaction = Transaction.new(amount: params["transaction"]["amount"], user_id: current_user.id)
    #ActiveRecord::SubclassNotFound: Invalid single-table inheritance type: deposit is not a subclass of Transaction
    @transaction.update(type: params["transaction"]["type"])
    @transaction.save
    binding.pry
    if @transaction.type == "deposit"
      binding.pry
      current_user.balance += params["transaction"]["amount"].to_i
      current_user.save
      redirect to "/transactions/index"
    elsif @transaction.type == "withdrawl"
      current_user.balance -= params["transaction"]["amount"].to_i
      current_user.save
      redirect to "/transactions/index"
    else
      redirect to "/transactions/index"
    end
  end


  get '/transactions/:id/edit' do
    redirect_if_not_logged_in
  end

  patch '/tweets/:id' do
    redirect_if_not_logged_in
  end

  delete '/tweets/:id' do
    redirect_if_not_logged_in
  end






end
