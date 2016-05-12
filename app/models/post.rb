class Post < ActiveRecord::Base
  belongs_to :author
  has_many :comment
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 10 }
end
