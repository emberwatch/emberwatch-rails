require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:user_one) { FactoryGirl.create(:user) }
  let(:user_two) { FactoryGirl.create(:user) }

  before :each do
    allow_any_instance_of(described_class).to receive(:current_user).and_return(admin)
  end

  describe "GET #index" do
    before(:each) { user_one; user_two }

    it "returns a success response" do
      get :index, params: {}
      expect(response).to be_success
    end

    it "filters for the given params" do
      get :index, params: {
        filter: {
          email_eq: user_one.email
        }
      }
      json = JSON.parse(response.body)
      expect(json['data'].length).to be 1
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: user_one.to_param }
      expect(response).to be_success
    end
  end
end
