users = [
  User.create( email: "iulia@ex.com", password: "abcd1234" ),
  User.create( email: "glory@ex.com", password: "abcd1234" ),
  User.create( email: "jessica@ex.com", password: "abcd1234" )
]

users.each do |user|
  5.times do
    article = Article.create(content:Faker::Lorem.paragraph, title:Faker::Lorem.sentence, image:Faker::Avatar.image ,user: user)
    article.content.split(" ").each do |word|
      Word.create(name:word, known:true, user:user)
    end
  end
  article2 = Article.create(content:Faker::Lorem.paragraph, title:Faker::Lorem.sentence, image:Faker::Avatar.image ,user: user)
  article2.content.split(" ").each do |word|
    Word.create(name:word, known:false, translation:Faker::Hacker.noun, user:user)
  end
end
