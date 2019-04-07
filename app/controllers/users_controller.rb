class UsersController < ApplicationController
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/signup' do
  end

  post '/signup' do
  end

  get '/login' do
  end

  post '/login' do
  end

  get '/logout' do

  end

  get '/users/:slug'
  
  end
end
