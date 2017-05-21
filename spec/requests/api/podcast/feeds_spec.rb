require 'rails_helper'

RSpec.describe "Api::Podcast::Feeds", type: :request do
  let(:admin) { FactoryGirl.create :admin }
  let(:podcast_feed) { FactoryGirl.create :podcast_feed, id: '385eec4b-dd26-4f49-8ff2-d84861ae9541' }
  let(:token) { "Token #{AuthenticationService.new(admin).create_token}" }
  let(:headers) { { 'Authorization' => token } }

  before :each do
    podcast_feed
  end

  describe '#index' do
    it "works", doc: true do
      get api_podcast_feeds_path
      expect(response).to have_http_status(200)
    end
  end

  describe '#create' do
    it 'is successful', doc: true do
      attributes = { type: 'podcast/feeds', attributes: FactoryGirl.attributes_for(:podcast_feed) }
      post api_podcast_feeds_path, params: { data: attributes }, headers: headers
      expect(response).to be_successful
    end

    it 'is unprocessable with invalid data', doc: true do
      attributes = { type: 'podcast/feeds', attributes: FactoryGirl.attributes_for(:podcast_feed, url: '') }
      post api_podcast_feeds_path, params: { data: attributes }, headers: headers
      expect(response).to be_unprocessable
    end

    it 'is forbidden without valid session', doc: true do
      attributes = { type: 'podcast/feeds', attributes: FactoryGirl.attributes_for(:podcast_feed) }
      post api_podcast_feeds_path, params: { data: attributes }
      expect(response).to be_forbidden
    end
  end

  describe '#show' do
    it 'is successful', doc: true do
      get api_podcast_feed_path(id: podcast_feed.id)
      expect(response).to be_successful
    end
  end

  describe '#update' do
    it 'is successful', doc: true do
      attributes = { type: 'podcast/feeds', id: podcast_feed.id, attributes: { url: 'http://example.com/feed' } }
      patch api_podcast_feed_path(id: podcast_feed.id), params: { data: attributes }, headers: headers
      expect(response).to be_successful
    end

    it 'is unprocessable with invalid data', doc: true do
      attributes = { type: 'podcast/feeds', id: podcast_feed.id, attributes: { url: '' } }
      patch api_podcast_feed_path(id: podcast_feed.id), params: { data: attributes }, headers: headers
      expect(response).to be_unprocessable
    end

    it 'is forbidden without valid session', doc: true do
      attributes = { type: 'podcast/feeds', id: podcast_feed.id, attributes: { url: 'http://example.com/feed' } }
      patch api_podcast_feed_path(id: podcast_feed.id), params: { data: attributes }
      expect(response).to be_forbidden
    end
  end

  describe '#destroy' do
    it 'is successful', doc: true do
      delete api_podcast_feed_path(id: podcast_feed.id), headers: headers
      expect(response).to be_successful
    end

    it 'is forbidden without valid session', doc: true do
      delete api_podcast_feed_path(id: podcast_feed.id)
      expect(response).to be_forbidden
    end
  end
end
