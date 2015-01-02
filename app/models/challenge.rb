class Challenge < ActiveRecord::Base

  has_many :participations

 # has_many :users, through: :participations, as: :participants
  has_many :participants, through: :participations, class_name: 'User', foreign_key: 'user_id'

  scope :current, -> { where("end_at > ? and start_at < ?", Time.now, Time.now) }
  scope :ended, -> { where("end_at < ?", Time.now).order(end_at: :desc) }

end
