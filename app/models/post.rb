class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User"
  has_many :comments, dependent: :delete_all
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 10 }
end
