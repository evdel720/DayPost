require 'spec_helper'

RSpec.feature 'Users can edit posts' do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:post) { FactoryGirl.create(:post, title: "Luxury Title", author_id: user.id, content: "New content with long content") }
  let!(:comment) { FactoryGirl.create(:comment, post_id: post.id, author_id: user.id, content: "First comment") }

  before do
    login_as(user)
    visit post_path(:en, post)
    click_link "post_edit"
  end

  scenario "with valid attributes" do
    fill_in 'Title', with: 'Real funny story'
    fill_in 'Content', with: 'The weather is great today.'
    click_button 'post_update'

    expect(page).to have_content('Post has been updated.')
    expect(page).to have_content('Real funny story')
  end

  scenario "when providing invalid attributes" do
    fill_in 'Title', with: ''
    fill_in 'Content', with: 'c'
    click_button 'post_update'

    expect(page).to have_content('Post has not been updated.')
  end
end
