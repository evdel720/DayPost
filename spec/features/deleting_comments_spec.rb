require 'spec_helper'

RSpec.feature 'Users can delete comments' do
  let!(:user) { FactoryGirl.create(:user, :admin) }

  before do
    login_as(user)
    post = FactoryGirl.create(:post, title: "Luxury Title", content: "New content with long content")
    comment = FactoryGirl.create(:comment, post_id: post.id, author_id: user.id, content: "First comment")
    visit post_path(post)
  end

  scenario "successfully" do
    click_link 'Delete Comment'

    expect(page).to have_content('Comment has been deleted.')
  end
end
