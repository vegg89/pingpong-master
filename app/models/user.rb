class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :trackable, :validatable
  has_many :players
  has_many :games, through: :players

  scope :all_except_me, -> (current_user) { where("NOT id = ?", current_user.id) }
end
