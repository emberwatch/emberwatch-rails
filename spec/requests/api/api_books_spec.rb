require 'rails_helper'

RSpec.describe "Api::Books", type: :request do
  let(:admin) { FactoryGirl.create :admin }
  let(:book) { FactoryGirl.create :book, id: '385eec4b-dd26-4f49-8ff2-d84861ae9541' }
  let(:token) { "Token #{AuthenticationService.new(admin).create_token}" }
  let(:headers) { { 'Authorization' => token } }

  before :each do
    book
  end

  describe '#index' do
    it "works", doc: true do
      get api_books_path
      expect(response).to have_http_status(200)
    end
  end

  describe '#create' do
    it 'is successful', doc: true do
      attributes = { type: 'books', attributes: FactoryGirl.attributes_for(:book) }
      post api_books_path, params: { data: attributes }, headers: headers
      expect(response).to be_successful
    end

    it 'is unprocessable with invalid data', doc: true do
      attributes = { type: 'books', attributes: FactoryGirl.attributes_for(:book, title: '') }
      post api_books_path, params: { data: attributes }, headers: headers
      expect(response).to be_unprocessable
    end

    it 'is forbidden without valid session', doc: true do
      attributes = { type: 'books', attributes: FactoryGirl.attributes_for(:book) }
      post api_books_path, params: { data: attributes }
      expect(response).to be_forbidden
    end
  end

  describe '#show' do
    it 'is successful', doc: true do
      get api_book_path(id: book.id), headers: headers
      expect(response).to be_successful
    end
  end

  describe '#update' do
    it 'is successful', doc: true do
      attributes = { type: 'books', id: book.id, attributes: { title: 'new name' } }
      patch api_book_path(id: book.id), params: { data: attributes }, headers: headers
      expect(response).to be_successful
    end

    it 'is unprocessable with invalid data', doc: true do
      attributes = { type: 'books', id: book.id, attributes: { title: '' } }
      patch api_book_path(id: book.id), params: { data: attributes }, headers: headers
      expect(response).to be_unprocessable
    end

    it 'is forbidden without valid session', doc: true do
      attributes = { type: 'books', id: book.id, attributes: { title: 'new name' } }
      patch api_book_path(id: book.id), params: { data: attributes }
      expect(response).to be_forbidden
    end
  end

  describe '#destroy' do
    it 'is successful', doc: true do
      delete api_book_path(id: book.id), headers: headers
      expect(response).to be_successful
    end

    it 'is forbidden without valid session', doc: true do
      delete api_book_path(id: book.id)
      expect(response).to be_forbidden
    end
  end
end
