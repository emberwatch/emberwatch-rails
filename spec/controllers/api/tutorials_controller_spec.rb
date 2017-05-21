require 'rails_helper'

RSpec.describe Api::TutorialsController, type: :controller do
  let(:valid_attributes) do
    {
      type: 'tutorials',
      attributes: FactoryGirl.attributes_for(:tutorial)
    }
  end

  let(:invalid_attributes) do
    {
      type: 'tutorials',
      attributes: FactoryGirl.attributes_for(:tutorial, title: '')
    }
  end

  let(:admin) { FactoryGirl.create(:admin) }
  let(:tutorial) { FactoryGirl.create(:tutorial) }

  before :each do
    allow_any_instance_of(described_class).to receive(:current_user).and_return(admin)
  end

  describe "GET #index" do
    before(:each) { tutorial }

    it "returns a success response" do
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: tutorial.to_param }
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Api::Tutorial" do
        expect {
          post :create, params: { data: valid_attributes }
        }.to change(Tutorial, :count).by(1)
      end

      it "renders a JSON response with the new tutorial" do
        post :create, params: { data: valid_attributes }
        expect(response).to be_successful
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new tutorial" do
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
          types: 'tutorials',
          id: tutorial.to_param,
          attributes: {
            title: 'FOO'
          }
        }
      end

      let(:invalid_attributes) do
        {
          types: 'tutorials',
          id: tutorial.to_param,
          attributes: {
            title: ''
          }
        }
      end

      it "updates the requested tutorial" do
        expect {
          put :update, params: { id: tutorial.to_param, data: new_attributes }
        }.to change { tutorial.reload.title }.to 'FOO'
      end

      it "renders a JSON response with the tutorial" do
        put :update, params: { id: tutorial.to_param, tutorial: valid_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/vnd.api+json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the tutorial" do
        put :update, params: { id: tutorial.to_param, data: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/vnd.api+json')
      end
    end
  end

  describe "DELETE #destroy" do
    before(:each) { tutorial }

    it "is successful" do
      delete :destroy, params: { id: tutorial.to_param }
      expect(response).to be_successful
    end

    it "destroys the requested tutorial" do
      expect {
        delete :destroy, params: { id: tutorial.to_param }
      }.to change(Tutorial, :count).by(-1)
    end
  end

end
