require 'spec_helper'

feature 'Creating Posts' do
  scenario "can create a post" do
    visit '/'

    click_link 'New Post'

    fill_in 'Title', with: 'Real funny story'
    fill_in 'Content', with: 'The weather is great today.'
    click_button 'Create Post'

    expect(page).to have_content('Post has been created.')
  end
end
