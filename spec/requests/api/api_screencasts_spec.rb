require 'rails_helper'

RSpec.describe "Api::Screencasts", type: :request do
  let(:admin) { FactoryGirl.create :admin }
  let(:screencast) { FactoryGirl.create :screencast, id: '385eec4b-dd26-4f49-8ff2-d84861ae9541' }
  let(:token) { "Token #{AuthenticationService.new(admin).create_token}" }
  let(:headers) { { 'Authorization' => token } }

  before :each do
    screencast
  end

  describe '#index' do
    it "works", doc: true do
      get api_screencasts_path
      expect(response).to have_http_status(200)
    end
  end

  describe '#create' do
    it 'is successful', doc: true do
      attributes = { type: 'screencasts', attributes: FactoryGirl.attributes_for(:screencast) }
      post api_screencasts_path, params: { data: attributes }, headers: headers
      expect(response).to be_successful
    end

    it 'is unprocessable with invalid data', doc: true do
      attributes = { type: 'screencasts', attributes: FactoryGirl.attributes_for(:screencast, title: '') }
      post api_screencasts_path, params: { data: attributes }, headers: headers
      expect(response).to be_unprocessable
    end

    it 'is forbidden without valid session', doc: true do
      attributes = { type: 'screencasts', attributes: FactoryGirl.attributes_for(:screencast) }
      post api_screencasts_path, params: { data: attributes }
      expect(response).to be_forbidden
    end
  end

  describe '#show' do
    it 'is successful', doc: true do
      get api_screencast_path(id: screencast.id)
      expect(response).to be_successful
    end
  end

  describe '#update' do
    it 'is successful', doc: true do
      attributes = { type: 'screencasts', id: screencast.id, attributes: { title: 'new title' } }
      patch api_screencast_path(id: screencast.id), params: { data: attributes }, headers: headers
      expect(response).to be_successful
    end

    it 'is unprocessable with invalid data', doc: true do
      attributes = { type: 'screencasts', id: screencast.id, attributes: { title: '' } }
      patch api_screencast_path(id: screencast.id), params: { data: attributes }, headers: headers
      expect(response).to be_unprocessable
    end

    it 'is forbidden without valid session', doc: true do
      attributes = { type: 'screencasts', id: screencast.id, attributes: { title: 'new title' } }
      patch api_screencast_path(id: screencast.id), params: { data: attributes }
      expect(response).to be_forbidden
    end
  end

  describe '#destroy' do
    it 'is successful', doc: true do
      delete api_screencast_path(id: screencast.id), headers: headers
      expect(response).to be_successful
    end

    it 'is forbidden without valid session', doc: true do
      delete api_screencast_path(id: screencast.id)
      expect(response).to be_forbidden
    end
  end
end
