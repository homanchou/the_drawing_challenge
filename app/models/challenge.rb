class Challenge < ActiveRecord::Base

  has_many :participations
  has_many :participants, through: :participations, class_name: 'User', foreign_key: 'user_id'
  has_many :votes

  scope :current, -> { where("end_at > ? and start_at < ?", Time.now, Time.now) }
  scope :ended, -> { where("end_at < ?", Time.now).order(end_at: :desc) }

  def has_participant?(user)
    !!participants.where(user_id: user.id)
  end

  def ended?
    self.end_at <= Time.now
  end

  def entries
    participations.where.not(submitted_at:nil)
  end

  def self.previous
    where("end_at < ?", Time.now).order(end_at: :desc).first
  end

end
