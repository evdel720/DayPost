require 'spec_helper'

RSpec.feature 'Users can delete posts' do
  let!(:post) { FactoryGirl.create(:post, title: "Luxury Title", content: "New content with long content") }

  scenario "successfully" do
    visit '/'
    click_link "Luxury Title"
    click_link 'Delete Post'

    expect(page).to have_content('Post has been deleted.')
  end
end
