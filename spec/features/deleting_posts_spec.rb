require 'spec_helper'

RSpec.feature 'Author and admin user can delete posts' do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:post) { FactoryGirl.create(:post, title: "Luxury Title", author_id: user.id, content: "New content with long content") }
  let!(:admin) { FactoryGirl.create(:user, :admin)}

  scenario "Author user can delete his own post" do
    login_as(user)
    visit post_path(:en, post)
    click_link 'post_delete'

    expect(page).to have_content('Post has been deleted.')
  end

  scenario "Admin user can delete any post" do
    login_as(admin)
    visit post_path(:en, post)
    click_link 'post_delete'

    expect(page).to have_content('Post has been deleted.')
  end
end
