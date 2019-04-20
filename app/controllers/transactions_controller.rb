class TransactionsController < ApplicationController
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

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
  end


  post '/transactions' do
    redirect_if_not_logged_in
    binding.pry
    @transaction = Transaction.new(amount: params["transaction"]["amount"], user_id: current_user.id)
    #ActiveRecord::SubclassNotFound: Invalid single-table inheritance type: deposit is not a subclass of Transaction
    if params["deposit"] == "on"
      current_user.balance += params["transaction"]["amount"].to_i
      current_user.transactions << @transaction
      current_user.save
      binding.pry
    elsif params["withdrawl"] == "on"
      current_user.balance -= params["transaction"]["amount"].to_i
      current_user.transactions << @transaction
      current_user.save
    else
    end
      redirect to "/transactions/index"
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
