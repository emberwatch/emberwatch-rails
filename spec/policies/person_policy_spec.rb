require 'rails_helper'

RSpec.describe PersonPolicy do

  let(:person) { FactoryGirl.create :person }
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
    it { should permit(nil, person) }
  end

  permissions :create? do
    it { should_not permit(nil, person) }
    it { should permit(admin, person) }
  end

  permissions :update? do
    it { should_not permit(nil, person) }
    it { should permit(admin, person) }
  end

  permissions :destroy? do
    it { should_not permit(nil, person) }
    it { should permit(admin, person) }
  end
end
