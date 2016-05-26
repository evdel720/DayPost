require 'spec_helper'

RSpec.feature 'Users can edit comments' do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:post) { FactoryGirl.create(:post, title: "Luxury Title", author_id: user.id, content: "New content with long content") }
  let!(:comment) { FactoryGirl.create(:comment, post_id: post.id, author_id: user.id, content: "First comment") }

  before do
    login_as(user)
    visit post_path(:en, post)
    click_link "comment_edit"
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
