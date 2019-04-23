
  
  Category.where(name: "Classical").first_or_create
  Category.where(name: "Drama").first_or_create
  Category.where(name: "Comedy").first_or_create

user1= User.create(
  id: 1,
  email: "cesar@gmail.com",
  created_at: "2019-04-22 11:28:04", 
  updated_at: "2019-04-22",
  provider: nil, 
  uid: nil
)

play = Play.create(
  id: 1,
  title: "Pudge",
  description: "This is a test where I used the hero Pudge of Dota 2", 
  updated_at: "2019-04-23 02:50:26",
  user_id: 2,
  category_id: 3
)

play2 = Play.create(
  id: 2,
  title: "Zeus",
  description: "This is a test where I used the hero Pudge of Dota 2", 
  updated_at: "2019-04-23 08:01:26",
  user_id: 1,
  category_id: 1
)
