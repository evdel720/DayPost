require 'spec_helper'

RSpec.feature 'Users can create new posts' do
  before do
    login_as(FactoryGirl.create(:user, :admin))
    visit '/'
    click_link 'New Post'
  end
  scenario "with valid attributes" do
    fill_in 'Title', with: 'Real funny story'
    fill_in 'Content', with: 'The weather is great today.'
    click_button 'Create Post'

    expect(page).to have_content('Post has been created.')
  end

  scenario "with invalid attributes" do
    fill_in 'Title', with: ''
    fill_in 'Content', with: 'c'
    click_button 'Create Post'

    expect(page).to have_content('Post has not been created.')
  end
end
