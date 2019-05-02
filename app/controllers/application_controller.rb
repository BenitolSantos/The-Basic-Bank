#require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :sessions_secret, "my_application_secret"
    register Sinatra::Flash
  end

  get '/' do
    erb :index
  end

  helpers do
    def redirect_if_not_logged_in
      if !logged_in?
        flash[:message] = "You need to login."
        redirect "/login"
      end

    end

    def logged_in?
      #!!session[:user_id]
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
      #User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def cents_to_dollars(cents) #helper method due to integers only in sqlite3
      dollars = cents/100 #dollars
      cents = cents%100 #cents, the remainder
      dollars.to_s + " dollars and " + cents.to_s + " cents"
    end

  end

end
