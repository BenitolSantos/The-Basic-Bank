class UsersController < ApplicationController
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  #sinatra study groups tuesday - friday next week
  #you can simplify it by removing profiles - amelie

  get '/signup' do
     erb :"users/create_user"
  end

  post '/signup' do
    #add if else to handle people with the same user name or email
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect to ('/signup')
    else
      if params[:balance] == ""
        params[:balance] = 0
      end
      @user = User.create(username: params[:username], password: params[:password], email: params[:email], balance: params[:balance], content: params[:content])
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
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password]) #keeps it secret via an activerecord method
      session[:user_id] = @user.id

      redirect "/transactions"
    else
      flash[:message] = "You don't have an account, you need to sign up."
      redirect to '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to ('/login')
    else
      redirect to ('/login')
    end
  end

  get '/users/:slug' do
    redirect_if_not_logged_in
    @user = User.find_by_slug(params[:slug])
    redirect "/transactions"
  end

  get '/users/:slug/edit' do
    redirect_if_not_logged_in
    @user = User.find_by_slug(params[:slug])
    erb :"/users/edit_user"
  end

  patch '/users/:slug' do
    redirect_if_not_logged_in
    @user = User.find_by_slug(params[:slug])
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect to ('/signup')
    else
      if params[:balance] == ""
        params[:balance] = 0
      end
      @user = User.update(username: params[:username], password: params[:password], email: params[:email], balance: params[:balance], content: params[:content])
      @user.save
      session[:user_id] = @user.id

      redirect to ("/transactions")
    end
  end

  delete '/users/:slug' do
      redirect_if_not_logged_in
      session.destroy
      @users = User.all
      @users.delete(current_user)
      redirect to '/signup'
  end
end
