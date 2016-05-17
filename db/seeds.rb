# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
unless User.exists?(email: "admin@daypost.com")
  User.create!(email: "admin@daypost.com", password: "password", admin: true)
end

["user1@daypost.com", "user2@daypost.com"].each do |email|
  User.create!(email: email, password: "password")
end

unless Post.exists?(title: "The first post")
  Post.create!(title: "The first post", content: "A sample project about The first post", author_id: User.where(admin: true).first.id )
end

unless Post.exists?(title: "The second post")
  Post.create!(title: "The second post", content: "A sample project about The second post", author_id: User.where(admin: false).first.id )
end

unless Comment.exists?(content: "The first comment")
  Comment.create!(content: "The first comment", author_id: User.where(admin: true).first.id, post_id: Post.first.id )
end

unless Comment.exists?(content: "The second comment")
  Comment.create!(content: "The second comment", author_id: User.where(admin: false).first.id, post_id: Post.first.id )
end
