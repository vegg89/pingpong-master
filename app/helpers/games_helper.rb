module GamesHelper
  def get_opponent(game, user_id)
    opponent = game.players.select { |player| player.user_id != user_id }
    opponent.first
  end

  def get_current_player(game, user_id)
    opponent = game.players.select { |player| player.user_id == user_id }
    opponent.first
  end

  def game_status(u_score, o_score)
    if u_score > o_score
      "W"
    elsif u_score === o_score
      "D"
    else
      "L"
    end
  end
end
