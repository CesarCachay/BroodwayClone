
  Category.create(name: "Classical")
  Category.create(name: "Drama")
  Category.create(name: "Comedy")

user1= User.create(
  email: "cesar@gmail.com",
  created_at: "2019-04-22 11:28:04", 
  updated_at: "2019-04-22",
  provider: nil, 
  uid: nil
)

user2= User.create(
  email: "rails@gmail.com",
  created_at: "2019-04-21 10:00:04", 
  updated_at: "2019-04-22",
  provider: nil, 
  uid: nil
)

play = Play.create(
  title: "Pudge",
  description: "This is a test where I used the hero Pudge of Dota 2", 
  updated_at: "2019-04-23 02:50:26",
  user_id: 2,
  category_id: 3
)

play2 = Play.create(
  title: "Zeus",
  description: "This is a test where I used the hero Pudge of Dota 2", 
  updated_at: "2019-04-23 08:01:26",
  user_id: 1,
  category_id: 1
)
