tags = %W[ c# java php javascript coffeescript android jquery c++ iphone asp.net python .net html mysql objective-c ios sql css ruby-on-rails c ruby django linux windows facebook osx wordpress ipad perl cocoa flash git r flex jquery node.js postgresql scala mongodb firefox google-chrome haskell vim sublime-text textmate photoshop illustrator web-design responsive-design mobile-design logo-design poster-design print-design typography illustration ]

puts "CREATE USERS"
20.times do
  User.create(
    email: Faker::Internet.email,
    password: 'password',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
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
    amount: rand(1..2).even? ? 0 : rand(1..2).even? ? 20 : 10,
    tag_list: tags.sample(rand(1..5)).join(", ")
  )
  request = user.requests.create(
    name: Faker::Lorem.sentences(2).join(" "),
    description: Faker::Lorem.paragraph,
    amount: rand(1..2).even? ? 0 : rand(1..2).even? ? 20 : 10,
    tag_list: tags.sample(rand(1..5)).join(", ")
  )
  rand(1..3).times do
    offer.meetings.create(
      start_time: DateTime.now + rand(5..60).minutes,
      booked: rand(1..3).even? ? true : false
      # start_time: DateTime.now + rand(1..3).days + rand(1..12).hours + rand(1..60).minutes
    )
  end
  rand(1..3).times do
    request.meetings.create(
      start_time: DateTime.now + rand(5..60).minutes,
      booked: rand(1..3).even? ? true : false
      # start_time: DateTime.now + rand(1..3).days + rand(1..12).hours + rand(1..60).minutes
    )
  end
end