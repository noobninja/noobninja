tags = %W[ c# java php javascript coffeescript android jquery c++ iphone asp.net python .net html mysql objective-c ios sql css ruby-on-rails c ruby django linux windows facebook osx wordpress ipad perl cocoa flash git r flex jquery node.js postgresql scala mongodb firefox google-chrome haskell vim sublime-text textmate photoshop illustrator web-design responsive-design mobile-design logo-design poster-design print-design typography illustration ]

puts "CREATE TAGS"
tags.each do |name|
  ActsAsTaggableOn::Tag.create(name: name)
end

puts "CREATE USERS"
User.create(
  email: "abreu.jamil@gmail.com",
  password: "11111111",
  name: "Jamil Abreu",
  username: "noob",
  description: Faker::Lorem.paragraph,
  tag_list: ["ruby", "ruby-on-rails", "javascript", "css", "git"],
  time_zone: "Eastern Time (US & Canada)",
  member: true
)
20.times do
  User.create(
    email: Faker::Internet.email,
    password: 'password',
    name: "#{Faker::Name.first_name} #{Faker::Name.last_name}",
    username: Faker::Lorem.words(2).join,
    description: Faker::Lorem.paragraph,
    tag_list: tags.sample(rand(1..5)).join(", "),
    time_zone: "Eastern Time (US & Canada)"
  )
end

puts "CREATE LESSONS"
20.times do
  user = User.all.sample
  offer = user.offers.create(
    name: Faker::Lorem.sentences(2).join(" "),
    description: Faker::Lorem.paragraph,
    amount: rand(1..2).even? ? 0 : rand(1..2).even? ? 2500 : 1500,
    tag_list: tags.sample(rand(1..5)).join(", ")
  )
  request = user.requests.create(
    name: Faker::Lorem.sentences(2).join(" "),
    description: Faker::Lorem.paragraph,
    amount: rand(1..2).even? ? 0 : rand(1..2).even? ? 2500 : 1500,
    tag_list: tags.sample(rand(1..5)).join(", ")
  )
  rand(1..3).times do
    offer.meetings.create(
      start_time: DateTime.now + rand(60..240).minutes
      # booked: rand(1..3).even? ? true : false
      # start_time: DateTime.now + rand(1..3).days + rand(1..12).hours + rand(1..60).minutes
    )
  end
  rand(1..3).times do
    request.meetings.create(
      start_time: DateTime.now + rand(60..240).minutes
      # booked: rand(1..3).even? ? true : false
      # start_time: DateTime.now + rand(1..3).days + rand(1..12).hours + rand(1..60).minutes
    )
  end
end