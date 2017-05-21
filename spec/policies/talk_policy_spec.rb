require 'rails_helper'

RSpec.describe TalkPolicy do

  let(:talk) { FactoryGirl.create :talk }
  let(:admin) { FactoryGirl.create :admin }

  subject { described_class }

  permissions ".scope" do
    it 'returns the given scope' do
      expect(subject::Scope.new(nil, 'foo').resolve).to eql('foo')
    end
  end

  permissions :index? do
    it { should permit(nil) }
  end

  permissions :show? do
    it { should permit(nil, talk) }
  end

  permissions :create? do
    it { should_not permit(nil, talk) }
    it { should permit(admin, talk) }
  end

  permissions :update? do
    it { should_not permit(nil, talk) }
    it { should permit(admin, talk) }
  end

  permissions :destroy? do
    it { should_not permit(nil, talk) }
    it { should permit(admin, talk) }
  end
end
