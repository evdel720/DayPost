require 'spec_helper'

RSpec.feature 'Users can delete comments' do
  let!(:post) { FactoryGirl.create(:post, title: "Luxury Title", content: "New content with long content") }
  let!(:comment) { FactoryGirl.create(:comment, post_id: post.id, content: "First comment") }

  before do
    visit post_path(post)
  end

  scenario "successfully" do
    click_link 'Delete Comment'

    expect(page).to have_content('Comment has been deleted.')
  end
end
