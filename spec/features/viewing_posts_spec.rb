require 'spec_helper'

RSpec.feature 'Users can view posts' do
  let!(:user) { FactoryGirl.create(:user, :admin) }
  scenario "with the post details" do
    visit "/"
    login_as(user)
    post = FactoryGirl.create(:post, title: "Luxury Title", content: "New content with long content")
    comment = FactoryGirl.create(:comment, post_id: post.id, author_id: user.id, content: "First comment")
    visit post_path(post)
    expect(page).to have_content(comment.content)
    expect(page.current_url).to eq post_url(post)
  end
end
