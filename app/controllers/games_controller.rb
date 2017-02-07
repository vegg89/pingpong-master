require 'elo'

class GamesController < ApplicationController
  def index
    @games = current_user.games
  end

  def new
    @game = Game.new
    @opponent = @game.players.build
    @player = @game.players.build(user_id: current_user.id)
  end

  def create
    @game = Game.new(game_params)
    @player = @game.players.select { |player| player.user_id == current_user.id }.first
    @opponent = @game.players.reject { |player| player.user_id == current_user.id}.first
    if @game.save
      update_ratings
      redirect_to root_url
    else
      render 'new'
    end
  end

  private
    def game_params
      params.require(:game).permit(:game_date, players_attributes: [:user_id, :score])
    end

    def update_ratings
      p1 = @player.user
      p2 = @opponent.user
      res = calculate_result(@player, @opponent)
      Match.new(p1, p2, res)
      p1.save!
      p2.save!
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
