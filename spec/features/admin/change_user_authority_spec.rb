require 'spec_helper'

RSpec.feature "Admins can change a user's authority" do
  let(:admin) { FactoryGirl.create(:user, :admin) }
  let(:user) { FactoryGirl.create (:user) }

  before do
    login_as(admin)
  end

  scenario "successfully" do
    visit admin_user_path(user)
    click_link "Change Authority"
    expect(user.admin).equal?(true)
    click_link "Change Authority"
    expect(user.admin).equal?(false)
  end

  scenario "cannot change his own authority" do
    visit admin_user_path(admin)
    click_link "Change Authority"
    expect(page).to have_content "You cannot make yourself as non-admin user."
    expect(admin.admin).equal?(true)
  end
end
