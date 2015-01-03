class Participation < ActiveRecord::Base

  belongs_to :participant, class_name: 'User', foreign_key: 'user_id'
  belongs_to :challenge
  has_one :entry

end
