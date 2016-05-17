class Comment < ActiveRecord::Base
  belongs_to :author, class_name: "User"
  belongs_to :post
  has_and_belongs_to_many :liked, join_table: "comment_liked", class_name: "User", uniq: true
  validates :content, presence: true, length: { minimum: 5 }
end
