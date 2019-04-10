class ExchangesController < ApplicationController
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }















end
