class TransactionsController < ApplicationController
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/transactions' do
    if logged_in?
      @tweets = Tweet.all
      erb : ''
    else
      redirect to "/login"
    end
  end

  get '/transactions/new' do
    if logged_in?
      erb '/transactions/new'
    else
      redirect to "/login"
    end
  end












end
