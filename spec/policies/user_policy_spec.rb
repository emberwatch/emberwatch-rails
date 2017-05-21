require 'rails_helper'

RSpec.describe UserPolicy do

  let(:user) { FactoryGirl.create :user }
  let(:user_two) { FactoryGirl.create :user }
  let(:admin) { FactoryGirl.create :admin }

  subject { described_class }

  permissions ".scope" do
    it 'returns the given scope for admins' do
      expect(subject::Scope.new(admin, 'foo').resolve).to eql('foo')
    end

    it 'returns an empty scope for unauthorized users' do
      user
      expect(subject::Scope.new(nil, User.all).resolve).to be_empty
    end
  end

  permissions :index? do
    it { should permit(nil) }
  end

  permissions :show? do
    it { should_not permit(nil, user) }
    it { should permit(admin, user) }
    it { should permit(user, user) }
    it { should_not permit(user, user_two) }
  end

  permissions :create? do
    it { should_not permit(nil, user) }
    it { should_not permit(admin, user) }
  end

  permissions :update? do
    it { should_not permit(nil, user) }
    it { should_not permit(admin, user) }
  end

  permissions :destroy? do
    it { should_not permit(nil, user) }
    it { should_not permit(admin, user) }
  end
end
