require 'spec_helper'

RSpec.feature 'Users can view posts' do
  let!(:post) { FactoryGirl.create(:post, title: "Luxury Title", content: "New content with long content") }
  let!(:comment) { FactoryGirl.create(:comment, content: "First comment") }
  scenario "with the post details" do
    visit "/"

    click_link "Luxury Title"
    expect(page.current_url).to eq post_url(post)
    expect(page).to have_content(comment.content)
  end
end
