class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User"
  has_many :comments, dependent: :delete_all
  has_and_belongs_to_many :liked, join_table: "post_liked", class_name: "User", uniq: true
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 10 }
end
