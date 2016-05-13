class Post < ActiveRecord::Base
  belongs_to :author
  has_many :comments
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 10 }
  validates :author_id, presence: true
end
