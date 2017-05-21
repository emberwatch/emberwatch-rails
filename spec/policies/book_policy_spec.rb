require 'rails_helper'

RSpec.describe BookPolicy do

  let(:book) { FactoryGirl.create :book }
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
    it { should permit(nil, book) }
  end

  permissions :create? do
    it { should_not permit(nil, book) }
    it { should permit(admin, book) }
  end

  permissions :update? do
    it { should_not permit(nil, book) }
    it { should permit(admin, book) }
  end

  permissions :destroy? do
    it { should_not permit(nil, book) }
    it { should permit(admin, book) }
  end
end
