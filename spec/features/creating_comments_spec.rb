require 'spec_helper'

RSpec.feature 'Users can create new comments' do
  let!(:post) { FactoryGirl.create(:post, title: "Luxury Title", content: "New content with long content") }

  before do
    visit post_path(post)
  end

  scenario "with valid attributes" do
    fill_in 'Content', with: 'This is new comment content.'
    click_button 'Leave this comment'

    expect(page).to have_content('Comment has been created.')
    expect(page).to have_content('This is new comment content.')
  end

  scenario "with invalid attributes" do
    fill_in 'Content', with: 'zz'
    click_button 'Leave this comment'

    expect(page).to have_content('Comment has not been created.')
  end
end
