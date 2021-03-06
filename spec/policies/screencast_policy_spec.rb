require 'rails_helper'

RSpec.describe ScreencastPolicy do

  let(:screencast) { FactoryGirl.create :screencast }
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
    it { should permit(nil, screencast) }
  end

  permissions :create? do
    it { should_not permit(nil, screencast) }
    it { should permit(admin, screencast) }
  end

  permissions :update? do
    it { should_not permit(nil, screencast) }
    it { should permit(admin, screencast) }
  end

  permissions :destroy? do
    it { should_not permit(nil, screencast) }
    it { should permit(admin, screencast) }
  end
end
