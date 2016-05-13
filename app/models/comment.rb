class Comment < ActiveRecord::Base
  belongs_to :author
  belongs_to :post
  validates :content, presence: true, length: { minimum: 5 }
  validates :author_id, presence: true
end
