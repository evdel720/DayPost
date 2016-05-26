require 'spec_helper'

RSpec.feature 'Users can only see the appropriate links' do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:author) { FactoryGirl.create(:user) }
  let!(:admin) { FactoryGirl.create(:user, :admin) }
  let!(:post) { FactoryGirl.create(:post, title: "Luxury Title", author_id: author.id, content: "New content with long content") }
  let!(:comment) { FactoryGirl.create(:comment, post_id: post.id, author_id: author.id, content: "First comment") }

  context "anonymous users" do
    scenario "cannot see the New Post link and logout link" do
      visit "/"
      expect(page).not_to have_link "New Post"
      expect(page).not_to have_link "Sign out"
      expect(page).to have_link "Sign in"
      expect(page).to have_link "Sign up"
    end

    scenario "cannot see the edit, delete post, comment links" do
      visit post_path(:en, post)
      expect(page).not_to have_link "post_edit"
      expect(page).not_to have_link "comment_edit"
      expect(page).not_to have_link "post_delete"
      expect(page).not_to have_link "comment_delete"
    end

    scenario "cannot see the comment form" do
      visit post_path(:en, post)
      expect(page).not_to have_button 'Leave this comment'
    end
  end

  context "non-admin non-author users" do
    before do
      login_as(user)
    end

    scenario "can see the New Post link and logout link" do
      visit "/"
      expect(page).to have_link "New Post"
      expect(page).to have_link "Sign out"
    end

    scenario "cannot see the edit, delete post, comment links" do
      visit post_path(:en, post)
      expect(page).not_to have_link "post_edit"
      expect(page).not_to have_link "comment_edit"
      expect(page).not_to have_link "post_delete"
      expect(page).not_to have_link "comment_delete"
    end

    scenario "can see the comment form" do
      visit post_path(:en, post)
      expect(page).to have_button 'Leave this comment'
    end
  end

  context "author users" do
    before do
      login_as(author)
    end

    scenario "can see the edit, delete post, comment links" do
      visit post_path(:en, post)
      expect(page).to have_link "post_edit"
      expect(page).to have_link "comment_edit"
      expect(page).to have_link "post_delete"
      expect(page).to have_link "comment_delete"
    end
  end

  context "non-author but admin users" do
    before do
      login_as(admin)
    end

    scenario "can see only delete post, comment links" do
      visit post_path(:en, post)
      expect(page).to have_link "post_delete"
      expect(page).to have_link "comment_delete"
    end
  end
end
