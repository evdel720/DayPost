require 'spec_helper'

RSpec.feature 'Users can edit posts' do
  let(:post) { FactoryGirl.create(:post, title: "Luxury Title", content: "New content with long content") }
  let!(:user) { FactoryGirl.create(:user, :admin) }
  before do
    visit "/"
    login_as(user)
    visit post_path(post)
    click_link "Edit Post"
  end

  scenario "with valid attributes" do
    fill_in 'Title', with: 'Real funny story'
    fill_in 'Content', with: 'The weather is great today.'
    click_button 'Update Post'

    expect(page).to have_content('Post has been updated.')
    expect(page).to have_content('Real funny story')
  end

  scenario "when providing invalid attributes" do
    fill_in 'Title', with: ''
    fill_in 'Content', with: 'c'
    click_button 'Update Post'

    expect(page).to have_content('Post has not been updated.')
  end
end
