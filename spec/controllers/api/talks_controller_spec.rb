require 'rails_helper'

RSpec.describe Api::TalksController, type: :controller do
  let(:valid_attributes) do
    {
      type: 'talks',
      attributes: FactoryGirl.attributes_for(:talk)
    }
  end

  let(:invalid_attributes) do
    {
      type: 'talks',
      attributes: FactoryGirl.attributes_for(:talk, title: '')
    }
  end

  let(:admin) { FactoryGirl.create(:admin) }
  let(:talk) { FactoryGirl.create(:talk) }

  before :each do
    allow_any_instance_of(described_class).to receive(:current_user).and_return(admin)
  end

  describe "GET #index" do
    before(:each) { talk }

    it "returns a success response" do
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: talk.to_param }
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Api::Talk" do
        expect {
          post :create, params: { data: valid_attributes }
        }.to change(Talk, :count).by(1)
      end

      it "renders a JSON response with the new talk" do
        post :create, params: { data: valid_attributes }
        expect(response).to be_successful
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new talk" do
        post :create, params: { data: invalid_attributes }
        expect(response).to be_unprocessable
        expect(response.content_type).to eq('application/vnd.api+json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        {
          types: 'talks',
          id: talk.to_param,
          attributes: {
            title: 'FOO'
          }
        }
      end

      let(:invalid_attributes) do
        {
          types: 'talks',
          id: talk.to_param,
          attributes: {
            title: ''
          }
        }
      end

      it "updates the requested talk" do
        expect {
          put :update, params: { id: talk.to_param, data: new_attributes }
        }.to change { talk.reload.title }.to 'FOO'
      end

      it "renders a JSON response with the talk" do
        put :update, params: { id: talk.to_param, talk: valid_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/vnd.api+json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the talk" do
        put :update, params: { id: talk.to_param, data: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/vnd.api+json')
      end
    end
  end

  describe "DELETE #destroy" do
    before(:each) { talk }

    it "is successful" do
      delete :destroy, params: { id: talk.to_param }
      expect(response).to be_successful
    end

    it "destroys the requested talk" do
      expect {
        delete :destroy, params: { id: talk.to_param }
      }.to change(Talk, :count).by(-1)
    end
  end

end
