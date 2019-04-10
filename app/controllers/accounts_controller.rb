class AccountsController < ApplicationController
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }







end
#cmd / equals multiline comment
