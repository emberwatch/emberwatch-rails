require 'rails_helper'

RSpec.describe TutorialPolicy do

  let(:tutorial) { FactoryGirl.create :tutorial }
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
    it { should permit(nil, tutorial) }
  end

  permissions :create? do
    it { should_not permit(nil, tutorial) }
    it { should permit(admin, tutorial) }
  end

  permissions :update? do
    it { should_not permit(nil, tutorial) }
    it { should permit(admin, tutorial) }
  end

  permissions :destroy? do
    it { should_not permit(nil, tutorial) }
    it { should permit(admin, tutorial) }
  end
end
