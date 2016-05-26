require 'spec_helper'

RSpec.describe PostPolicy do
  context "permissions" do
    subject { PostPolicy.new(user, post) }

    let(:user) { FactoryGirl.create(:user) }
    let(:admin) { FactoryGirl.create(:user, :admin) }
    let(:post) { FactoryGirl.create(:post) }


    context "for anonymous users" do
      let(:user) { nil }

      it { should permit_action :show }
      it { should_not permit_action :create }
      it { should_not permit_action :update }
      it { should_not permit_action :destroy }
    end

    context "for signed in author users" do
      let(:user) { FactoryGirl.create(:user) }
      let(:post) { FactoryGirl.create(:post, author_id: user.id) }
      it { should permit_action :show }
      it { should permit_action :create }
      it { should permit_action :update }
      it { should permit_action :destroy }
    end

    context "for signed in non-author users" do
      let(:user) { FactoryGirl.create(:user) }
      let(:post) { FactoryGirl.create(:post) }
      it { should permit_action :show }
      it { should permit_action :create }
      it { should_not permit_action :update }
      it { should_not permit_action :destroy }
    end

    context "for signed in non-author but admin users" do
      let(:user) { FactoryGirl.create(:user, :admin) }
      let(:post) { FactoryGirl.create(:post) }
      it { should permit_action :show }
      it { should permit_action :create }
      it { should_not permit_action :update }
      it { should permit_action :destroy }
    end
  end
end
