require 'elo'

class GamesController < ApplicationController
  def index
    @games = current_user.games
  end

  def new
    @users = User.all_except_me(current_user)
  end

  def create
    @game = Game.create!(game_params)
    @opponent = User.find(params["opponent"]["id"])
    @opponent.players.create!(game: @game, score: opponent_params[:score])
    current_user.players.create!(game: @game, score: player_params[:score])
    update_ratings
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

    def update_ratings
      p1_res = current_user.players.where(game: @game).first
      p2_res = @opponent.players.where(game: @game).first
      res = calculate_result(p1_res, p2_res)
      Match.new(current_user, @opponent, res)
      current_user.save!
      @opponent.save!
    end

    def calculate_result(p1, p2)
      if p1.score > p2.score
        1
      elsif p1.score == p2.score
        0.5
      else
        0
      end
    end
end
