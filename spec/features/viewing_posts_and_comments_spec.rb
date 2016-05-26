require 'spec_helper'

RSpec.feature 'Users can view posts' do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:post) { FactoryGirl.create(:post, title: "Luxury Title", author_id: user.id, content: "New content with long content") }
  let!(:comment) { FactoryGirl.create(:comment, post_id: post.id, author_id: user.id, content: "First comment") }

  scenario "with the post details" do
    login_as(user)
    visit post_path(:en, post)
    expect(page).to have_content(post.title)
    expect(page).to have_content(post.content)
    expect(page).to have_content(comment.content)
    expect(page.current_url).to eq post_url(:en, post)
  end
end
