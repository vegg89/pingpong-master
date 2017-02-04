class GamesController < ApplicationController
  def new
    @users = User.all_except_me(current_user)
  end
end
