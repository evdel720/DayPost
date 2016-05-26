require 'spec_helper'

RSpec.feature 'Users can like comments' do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:post) { FactoryGirl.create(:post, title: "Luxury Title", author_id: user.id, content: "New content with long content") }
  let!(:comment) { FactoryGirl.create(:comment, post_id: post.id, author_id: user.id, content: "First comment") }

  before do
    login_as(user)
    visit post_path(:en, post)
  end

  scenario "for the first time only" do
    click_link "comment_like"
    expect(page).to have_content('You liked this comment.')

    click_link "comment_like"
    expect(page).to have_content('You already liked this comment.')
  end
end
