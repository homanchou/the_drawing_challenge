class Challenge < ActiveRecord::Base

  has_many :participations

 # has_many :users, through: :participations, as: :participants
  has_many :participants, through: :participations, class_name: 'User', foreign_key: 'user_id'
end
