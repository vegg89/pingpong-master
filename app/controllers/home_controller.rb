class HomeController < ApplicationController
  def index
    @users = User.includes(:games)
  end
end
