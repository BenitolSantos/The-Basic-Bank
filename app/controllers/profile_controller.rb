class ProfilesController < ApplicationController
  #"account" changed to "profile" do to account not working with ApplicationController
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get "/profiles" do
  end

  get "/profiles/new" do
  end

  get "/profiles/:id" do
  end

  get "/profiles/:id/edit" do

  end

  patch "/profiles/:id" do

  end

  delete "/profiles/:id" do

  end








end
