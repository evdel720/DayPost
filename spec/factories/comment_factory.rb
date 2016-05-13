FactoryGirl.define do
  factory :comment do
    content "Example comment content"
    post_id 1
    author_id 1
  end
end
