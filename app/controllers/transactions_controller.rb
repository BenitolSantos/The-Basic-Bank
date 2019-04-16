class TransactionsController < ApplicationController
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/transactions' do
    redirect_if_not_logged_in
  end

  get '/transactions/new' do
    redirect_if_not_logged_in
  end


  get '/transactions/:id' do
    redirect_if_not_logged_in
  end


  post '/transactions' do
    redirect_if_not_logged_in
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
