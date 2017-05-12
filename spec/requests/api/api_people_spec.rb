require 'rails_helper'

RSpec.describe "Api::People", type: :request do
  let(:admin) { FactoryGirl.build :admin }
  let(:person) { FactoryGirl.create :person, id: '385eec4b-dd26-4f49-8ff2-d84861ae9541' }

  before :each do
    person
  end

  describe '#index' do
    it "works", doc: true do
      # FIXME Send real headers as soon as it's implemented
      allow_any_instance_of(Api::PeopleController).to receive(:current_user).and_return(admin)
      get api_people_path
      expect(response).to have_http_status(200)
    end
  end

  describe '#create' do
    it 'is successful', doc: true do
      # FIXME Send real headers as soon as it's implemented
      allow_any_instance_of(Api::PeopleController).to receive(:current_user).and_return(admin)
      attributes = { type: 'people', attributes: FactoryGirl.attributes_for(:person) }
      post api_people_path, params: { data: attributes }
      expect(response).to be_successful
    end

    it 'is unprocessable with invalid data', doc: true do
      # FIXME Send real headers as soon as it's implemented
      allow_any_instance_of(Api::PeopleController).to receive(:current_user).and_return(admin)
      attributes = { type: 'people', attributes: FactoryGirl.attributes_for(:person, name: '') }
      post api_people_path, params: { data: attributes }
      expect(response).to be_unprocessable
    end

    it 'is forbidden without valid session', doc: true do
      attributes = { type: 'people', attributes: FactoryGirl.attributes_for(:person) }
      post api_people_path, params: { data: attributes }
      expect(response).to be_forbidden
    end
  end

  describe '#show' do
    it 'is successful', doc: true do
      get api_person_path(id: person.id)
      expect(response).to be_successful
    end
  end

  describe '#update' do
    it 'is successful', doc: true do
      # FIXME Send real headers as soon as it's implemented
      allow_any_instance_of(Api::PeopleController).to receive(:current_user).and_return(admin)
      attributes = { type: 'people', id: person.id, attributes: { name: 'new name' } }
      patch api_person_path(id: person.id), params: { data: attributes }
      expect(response).to be_successful
    end

    it 'is unprocessable with invalid data', doc: true do
      # FIXME Send real headers as soon as it's implemented
      allow_any_instance_of(Api::PeopleController).to receive(:current_user).and_return(admin)
      attributes = { type: 'people', id: person.id, attributes: { name: '' } }
      patch api_person_path(id: person.id), params: { data: attributes }
      expect(response).to be_unprocessable
    end

    it 'is forbidden without valid session', doc: true do
      attributes = { type: 'people', id: person.id, attributes: { name: 'new name' } }
      patch api_person_path(id: person.id), params: { data: attributes }
      expect(response).to be_forbidden
    end
  end

  describe '#destroy' do
    it 'is successful', doc: true do
      # FIXME Send real headers as soon as it's implemented
      allow_any_instance_of(Api::PeopleController).to receive(:current_user).and_return(admin)
      delete api_person_path(id: person.id)
      expect(response).to be_successful
    end

    it 'is forbidden without valid session', doc: true do
      delete api_person_path(id: person.id)
      expect(response).to be_forbidden
    end
  end
end
