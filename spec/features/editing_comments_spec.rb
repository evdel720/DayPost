require 'spec_helper'

RSpec.feature 'Users can edit posts' do
  let!(:user) { FactoryGirl.create(:user, :admin) }

  before do
    login_as(user)
    post = FactoryGirl.create(:post, title: "Luxury Title", content: "New content with long content")
    comment = FactoryGirl.create(:comment, post_id: post.id, author_id: user.id, content: "First comment")
    visit post_path(post)
    click_link "Edit Comment"
  end

  scenario "with valid attributes" do
    fill_in 'Content', with: 'Second comment.'
    click_button 'Update this comment'

    expect(page).to have_content('Comment has been updated.')
    expect(page).to have_content('Second comment.')
  end

  scenario "when providing invalid attributes" do
    fill_in 'Content', with: 'c'
    click_button 'Update this comment'

    expect(page).to have_content('Comment has not been updated.')
  end
end
