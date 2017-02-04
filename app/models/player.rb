class Player < ActiveRecord::Base
  belongs_to :user
  bleongs_to :game
end
