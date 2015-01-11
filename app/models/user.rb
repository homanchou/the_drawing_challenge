class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :omniauthable, :omniauth_providers => [:facebook]

  #devise omniauth method

  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first_or_initialize
    user.email = auth.info.email
    user.password ||= Devise.friendly_token[0,20]
    user.name = auth.info.name   # assuming the user model has a name
    user.avatar = auth.info.image # assuming the user model has an image
    user.oauth = auth
    user.save!
    return user
  end

  has_many :participations
  has_many :challenges, through: :participations
  has_many :votes

  def find_participation(challenge)
    return nil if challenge.nil?
    return participations.where(challenge_id: challenge.id).first
  end

  def participating_in?(challenge)
    !!find_participation(challenge)
  end

  def participate!(challenge)
    participations.create!(challenge: challenge)
  end

  def submitted_for_challenge?(challenge)
    participation = find_participation(challenge)
    !participation.submitted_at.nil?
  end

  def submit_for_challenge!(challenge, title, description, image_url)
    participation = find_participation(challenge)
    participation.with_lock do
      participation.title = title.strip
      participation.description = description.strip
      participation.image_url = image_url
      participation.submitted_at = Time.now
      participation.save!
    end
  end



end
