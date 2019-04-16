class UsersController < ApplicationController
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  #sinatra study groups tuesday - friday next week
  #you can simplify it by removing profiles - amelie

  get '/signup' do
    if !logged_in?
      erb :"users/create_user"
    else
      redirect to ('/transactions')
    end
  end

  post '/signup' do
    binding.pry
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect to ('/signup')
    else
      @user = User.create(username: params[:username], password: params[:password], email: params[:email])
      @user.save
      session[:user_id] = @user.id

      redirect to ("/transactions")
    end
  end

  get '/login' do
    if !logged_in?
      erb :"users/login"
    else
      redirect to ('/transactions')
    end
  end

  post '/login' do
    binding.pry
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id

      redirect "/transactions"
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to ('/login')
    else
      redirect to ('/')
    end
  end

  get '/users/:slug' do
    if logged_in?
      @user = User.find_by_slug(params[:slug])
      @accounts = @user.accounts
      erb :"/users/show"
    else
      redirect to '/signup'
    end
  end
end
