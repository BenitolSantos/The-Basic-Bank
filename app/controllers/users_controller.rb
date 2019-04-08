class UsersController < ApplicationController
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/signup' do
    if !logged_in?
      erb :"users/create_user"
    else
      #redirect to ('/accounts')
    end
  end

  post '/signup' do

  end

  get '/login' do
    if !logged_in?
      erb :"users/create_user"
    else
      #redirect to ('/accounts')
    end
  end

  post '/login' do

  end

  get '/logout' do


  end

  get '/users/:slug' do

  end
end
