require 'rails_helper'

RSpec.describe Podcast::FeedPolicy do

  let(:podcast_feed) { FactoryGirl.create :podcast_feed }
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
    it { should permit(nil, podcast_feed) }
  end

  permissions :create? do
    it { should_not permit(nil, podcast_feed) }
    it { should permit(admin, podcast_feed) }
  end

  permissions :update? do
    it { should_not permit(nil, podcast_feed) }
    it { should permit(admin, podcast_feed) }
  end

  permissions :destroy? do
    it { should_not permit(nil, podcast_feed) }
    it { should permit(admin, podcast_feed) }
  end
end
