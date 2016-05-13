# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

unless User.exists?(email: "user@daypost.com")
  User.create!(email: "user@daypost.com", password: "password")
end

["The first post", "The second post"].each do |title|
  unless Post.exists?(title: title)
    Post.create!(title: title, content: "A sample project about #{title}", author_id: User.first.id )
  end
end
