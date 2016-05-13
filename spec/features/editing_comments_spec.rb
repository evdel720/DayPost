require 'spec_helper'

RSpec.feature 'Users can edit posts' do
  let!(:post) { FactoryGirl.create(:post, title: "Luxury Title", content: "New content with long content") }
  let!(:comment) { FactoryGirl.create(:comment, post_id: post.id, content: "First comment") }

  before do
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
