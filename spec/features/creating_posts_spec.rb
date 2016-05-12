require 'spec_helper'

RSpec.feature 'Users can create new posts' do
  scenario "with valid attributes" do
    visit '/'

    click_link 'New Post'

    fill_in 'Title', with: 'Real funny story'
    fill_in 'Content', with: 'The weather is great today.'
    click_button 'Create Post'

    expect(page).to have_content('Post has been created.')
  end

  scenario "with invalid attributes" do
    visit '/'

    click_link 'New Post'

    fill_in 'Title', with: ''
    fill_in 'Content', with: 'c'
    click_button 'Create Post'

    expect(page).to have_content('Post has not been created.')
  end
end
