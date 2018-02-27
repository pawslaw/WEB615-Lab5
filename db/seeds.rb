# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create users
for i in 1..50 do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  name = "#{first_name} #{last_name}"
  email = Faker::Internet.free_email("#{first_name}.#{last_name}")

  user = User.new
  user.name = name
  user.email = email
  if user.save!
    p user
  end
end

# Create articles
for i in 1..50 do
  title = Faker::Hipster.sentence
  content = Faker::Hipster.paragraph

  article = Article.new
  article.title = title
  article.content = content
  article.user = User.offset(rand(User.count)).first
  if article.save!
    p article
  end
end

p 'Generating comments'

# Create 10 comments for each user on each article
for user in User.all
  for article in Article.all
    for i in 1..10 do
      comment = Comment.new
      comment.message = Faker::Hipster.sentence
      comment.article = article
      comment.user = user
      comment.save!
    end
  end
end

p 'Completed generating comments'