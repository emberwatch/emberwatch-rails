require 'rails_helper'

RSpec.describe EventPolicy do

  let(:event) { FactoryGirl.create :event }
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
    it { should permit(nil, event) }
  end

  permissions :create? do
    it { should_not permit(nil, event) }
    it { should permit(admin, event) }
  end

  permissions :update? do
    it { should_not permit(nil, event) }
    it { should permit(admin, event) }
  end

  permissions :destroy? do
    it { should_not permit(nil, event) }
    it { should permit(admin, event) }
  end
end
