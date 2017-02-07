class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  validates :score, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 21 }
  validates :user_id, presence: true
end
