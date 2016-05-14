require 'spec_helper'

RSpec.feature 'Users can like posts' do
  let!(:user) { FactoryGirl.create(:user, :admin) }
  let!(:post) { FactoryGirl.create(:post, title: "Luxury Title", content: "New content with long content") }
  before do
    login_as(user)
    visit post_path(post)
  end

  scenario "successfully" do
    click_button("Like it 0")
    expect(page).to have_content('You liked this post.')
    expect(page).to have_button('Like it 1')
  end
end
