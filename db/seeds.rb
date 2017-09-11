require 'database_cleaner'

puts 'Reset table ID to 1'
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

password = 'password'
salt = 'abcdef123456'
crypted_password = Sorcery::CryptoProviders::BCrypt.encrypt(password, salt)

puts 'Create users'
user = User.create!(
  username: 'Admin Admin',
  email: 'admin@example.com',
  password: password,
  salt: salt,
  crypted_password: crypted_password,
  role: 0
)

user2 = User.create!(
  username: 'Nimda Nimda',
  email: 'nimda@example.com',
  password: password,
  salt: salt,
  crypted_password: crypted_password,
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
