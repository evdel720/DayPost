
User.delete_all

10.times do
  User.create(
    email: Faker::Internet.email,
    password: 'adminuserpassword',
    admin: true
  )
end

50.times do
  User.create(
    email: Faker::Internet.email,
    password: 'userpassword'
  )
end

user_count = User.all.count

Post.delete_all

80.times do
  Post.create(title: Faker::Lorem.sentence, content: Faker::Lorem.paragraphs.join(" "), author_id: (1..user_count).to_a.sample, created_at: Faker::Date.between(2.days.ago, Date.today))
end

post_count = Post.all.count

Comment.delete_all

100.times do
  Comment.create(content: Faker::Lorem.paragraph, author_id: (1..user_count).to_a.sample, post_id: (1..post_count).to_a.sample, created_at: Faker::Date.between(2.days.ago, Date.today))
end
