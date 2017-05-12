require 'rails_helper'

RSpec.describe "Api::Talks", type: :request do
  let(:admin) { FactoryGirl.build :admin }
  let(:talk) { FactoryGirl.create :talk, id: '385eec4b-dd26-4f49-8ff2-d84861ae9541' }

  before :each do
    talk
  end

  describe '#index' do
    it "works", doc: true do
      # FIXME Send real headers as soon as it's implemented
      allow_any_instance_of(Api::TalksController).to receive(:current_user).and_return(admin)
      get api_talks_path
      expect(response).to have_http_status(200)
    end
  end

  describe '#create' do
    it 'is successful', doc: true do
      # FIXME Send real headers as soon as it's implemented
      allow_any_instance_of(Api::TalksController).to receive(:current_user).and_return(admin)
      attributes = { type: 'talks', attributes: FactoryGirl.attributes_for(:talk) }
      post api_talks_path, params: { data: attributes }
      expect(response).to be_successful
    end

    it 'is unprocessable with invalid data', doc: true do
      # FIXME Send real headers as soon as it's implemented
      allow_any_instance_of(Api::TalksController).to receive(:current_user).and_return(admin)
      attributes = { type: 'talks', attributes: FactoryGirl.attributes_for(:talk, title: '') }
      post api_talks_path, params: { data: attributes }
      expect(response).to be_unprocessable
    end

    it 'is forbidden without valid session', doc: true do
      attributes = { type: 'talks', attributes: FactoryGirl.attributes_for(:talk) }
      post api_talks_path, params: { data: attributes }
      expect(response).to be_forbidden
    end
  end

  describe '#show' do
    it 'is successful', doc: true do
      get api_talk_path(id: talk.id)
      expect(response).to be_successful
    end
  end

  describe '#update' do
    it 'is successful', doc: true do
      # FIXME Send real headers as soon as it's implemented
      allow_any_instance_of(Api::TalksController).to receive(:current_user).and_return(admin)
      attributes = { type: 'talks', id: talk.id, attributes: { title: 'new title' } }
      patch api_talk_path(id: talk.id), params: { data: attributes }
      expect(response).to be_successful
    end

    it 'is unprocessable with invalid data', doc: true do
      # FIXME Send real headers as soon as it's implemented
      allow_any_instance_of(Api::TalksController).to receive(:current_user).and_return(admin)
      attributes = { type: 'talks', id: talk.id, attributes: { title: '' } }
      patch api_talk_path(id: talk.id), params: { data: attributes }
      expect(response).to be_unprocessable
    end

    it 'is forbidden without valid session', doc: true do
      attributes = { type: 'talks', id: talk.id, attributes: { title: 'new title' } }
      patch api_talk_path(id: talk.id), params: { data: attributes }
      expect(response).to be_forbidden
    end
  end

  describe '#destroy' do
    it 'is successful', doc: true do
      # FIXME Send real headers as soon as it's implemented
      allow_any_instance_of(Api::TalksController).to receive(:current_user).and_return(admin)
      delete api_talk_path(id: talk.id)
      expect(response).to be_successful
    end

    it 'is forbidden without valid session', doc: true do
      delete api_talk_path(id: talk.id)
      expect(response).to be_forbidden
    end
  end
end
