class GamesController < ApplicationController
  def new
    @users = User.all_except_me(current_user)
  end

  def create
    @game = Game.create!(game_params)
    @opponent = User.find(params["opponent"]["id"])
    @opponent.players.create!(game: @game, score: opponent_params[:score])
    current_user.players.create!(game: @game, score: player_params[:score])
    redirect_to root_url
  end

  private
    def game_params
      params.require(:game).permit(:date)
    end

    def opponent_params
      params.require(:opponent).permit(:score)
    end

    def player_params
      params.require(:player).permit(:score)
    end
end
