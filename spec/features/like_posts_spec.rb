require 'spec_helper'

RSpec.feature 'Users can like posts' do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:post) { FactoryGirl.create(:post, title: "Luxury Title", author_id: user.id, content: "New content with long content") }

  before do
    login_as(user)
    visit post_path(:en, post)
  end

  scenario "for the first time only" do
    click_link "post_like"
    expect(page).to have_content('You liked this post.')

    click_link "post_like"
    expect(page).to have_content('You already liked this post.')
  end
end
