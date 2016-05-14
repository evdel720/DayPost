require 'spec_helper'

RSpec.feature 'Users can delete posts' do
  let!(:user) { FactoryGirl.create(:user, :admin) }
  let(:post) { FactoryGirl.create(:post, title: "Luxury Title", content: "New content with long content") }

  scenario "successfully" do
    visit '/'
    login_as(user)
    visit post_path(post)
    click_link 'Delete Post'

    expect(page).to have_content('Post has been deleted.')
  end
end
