require 'rails_helper'

RSpec.describe "Api::Users", type: :request do
  let(:admin) { FactoryGirl.create :admin }
  let(:user_one) { FactoryGirl.create :user }
  let(:user_two) { FactoryGirl.create :user }
  let(:token) { "Token #{AuthenticationService.new(admin).create_token}" }
  let(:headers) { { 'Authorization' => token } }

  before(:each) { user_one; user_two }

  describe '#index' do
    it "works", doc: true do
      get api_users_path, headers: headers
      expect(response).to have_http_status(200)
    end

    it "filters the data", doc: true do
      get api_users_path(filter: { email_eq: user_one.email }), headers: headers
      expect(response).to have_http_status(200)
    end

    context 'as a normal user' do
      let(:token) { "Token #{AuthenticationService.new(user_one).create_token}" }

      it "only returns the current user" do
        get api_users_path, headers: headers
        json = JSON.parse(response.body)
        expect(json['data'].length).to be 1
      end
    end
  end

  describe '#show' do
    it 'is successful', doc: true do
      get api_user_path(id: user_one.id), headers: headers
      expect(response).to be_successful
    end

    context 'without authentication' do
      it 'can not find the user' do
        get api_user_path(id: user_one.id)
        expect(response).to be_not_found
      end
    end

    context 'as a normal user' do
      let(:token) { "Token #{AuthenticationService.new(user_one).create_token}" }

      it 'is successful' do
        get api_user_path(id: user_one.id), headers: headers
        expect(response).to be_successful
      end

      it 'can not find other users' do
        get api_user_path(id: user_two.id), headers: headers
        expect(response).to be_not_found
      end
    end
  end
end
