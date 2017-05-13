require 'rails_helper'

RSpec.describe "Api::Events", type: :request do
  let(:admin) { FactoryGirl.create :admin }
  let(:event) { FactoryGirl.create :event, id: '385eec4b-dd26-4f49-8ff2-d84861ae9541' }
  let(:token) { "Token #{AuthenticationService.new(admin).create_token}" }
  let(:headers) { { 'Authorization' => token } }

  before :each do
    event
  end

  describe '#index' do
    it "works", doc: true do
      get api_events_path
      expect(response).to have_http_status(200)
    end
  end

  describe '#create' do
    it 'is successful', doc: true do
      attributes = { type: 'events', attributes: FactoryGirl.attributes_for(:event) }
      post api_events_path, params: { data: attributes }, headers: headers
      expect(response).to be_successful
    end

    it 'is unprocessable with invalid data', doc: true do
      attributes = { type: 'events', attributes: FactoryGirl.attributes_for(:event, name: '') }
      post api_events_path, params: { data: attributes }, headers: headers
      expect(response).to be_unprocessable
    end

    it 'is forbidden without valid session', doc: true do
      attributes = { type: 'events', attributes: FactoryGirl.attributes_for(:event) }
      post api_events_path, params: { data: attributes }
      expect(response).to be_forbidden
    end
  end

  describe '#show' do
    it 'is successful', doc: true do
      get api_event_path(id: event.id)
      expect(response).to be_successful
    end
  end

  describe '#update' do
    it 'is successful', doc: true do
      attributes = { type: 'events', id: event.id, attributes: { name: 'new name' } }
      patch api_event_path(id: event.id), params: { data: attributes }, headers: headers
      expect(response).to be_successful
    end

    it 'is unprocessable with invalid data', doc: true do
      attributes = { type: 'events', id: event.id, attributes: { name: '' } }
      patch api_event_path(id: event.id), params: { data: attributes }, headers: headers
      expect(response).to be_unprocessable
    end

    it 'is forbidden without valid session', doc: true do
      attributes = { type: 'events', id: event.id, attributes: { name: 'new name' } }
      patch api_event_path(id: event.id), params: { data: attributes }
      expect(response).to be_forbidden
    end
  end

  describe '#destroy' do
    it 'is successful', doc: true do
      delete api_event_path(id: event.id), headers: headers
      expect(response).to be_successful
    end

    it 'is forbidden without valid session', doc: true do
      delete api_event_path(id: event.id)
      expect(response).to be_forbidden
    end
  end
end
