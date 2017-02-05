puts 'Reset table ID to 1'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

puts 'Create users'
user = User.create!(
  username: 'Admin Admin',
  email: 'admin@example.com',
  password: 'password',
  password_confirmation: 'password',
  role: 0
)

user2 = User.create!(
  username: 'Nimda Nimda',
  email: 'nimda@example.com',
  password: 'password',
  password_confirmation: 'password',
  role: 1
)

puts 'Create blogs categories'
10.times do
  Category.create(
    name: Faker::Hipster.word
  )
end

puts 'Create blogs articles'
20.times do
  Blog.create(
    title: Faker::Hipster.words(4).join(' '),
    content: "<p>#{Faker::Hipster.paragraph}</p>",
    category_id: Category.all.map(&:id).sample,
    user_id: [user.id, user2.id].sample
  )
end
