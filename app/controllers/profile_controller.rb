class ProfilesController < ApplicationController
  #"account" changed to "profile" do to account not working with ApplicationController
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }















end
