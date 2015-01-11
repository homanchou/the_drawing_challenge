# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#used in development for some basic testing of voting


#create bunch of users

  10.times {
    User.create!(uid: Devise.friendly_token[0,20],
      password: Devise.friendly_token[0,20],
      name: Devise.friendly_token[0,20],
      email: "#{Devise.friendly_token[0,5]}@thing.com")
  }

  #create some challenges

  ['batgirl','wonder women', 'cinderella','voltron'].each_with_index do |title, index|
    Challenge.create!(title: title,
      start_at: index.days.from_now.beginning_of_day,
      end_at: (index +1).days.from_now.end_of_day)
  end

  #register users for all challenges
  User.find_each do |u|
    Challenge.find_each do |c|
      u.participate!(c) rescue nil
    end
  end

  #fill in random images
  suckr = ImageSuckr::GoogleSuckr.new
  Participation.find_each do |p|
    p.image_url = suckr.get_image_url
    p.submitted_at = Time.now
    p.save!
  end