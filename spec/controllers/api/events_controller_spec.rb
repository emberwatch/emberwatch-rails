require 'rails_helper'

RSpec.describe Api::EventsController, type: :controller do
  let(:valid_attributes) do
    {
      type: 'events',
      attributes: FactoryGirl.attributes_for(:event)
    }
  end

  let(:invalid_attributes) do
    {
      type: 'events',
      attributes: FactoryGirl.attributes_for(:event, name: '')
    }
  end

  let(:admin) { FactoryGirl.create(:admin) }
  let(:event) { FactoryGirl.create(:event) }

  before :each do
    allow_any_instance_of(described_class).to receive(:current_user).and_return(admin)
  end

  describe "GET #index" do
    before(:each) { event }

    it "returns a success response" do
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: event.to_param }
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Api::Event" do
        expect {
          post :create, params: { data: valid_attributes }
        }.to change(Event, :count).by(1)
      end

      it "renders a JSON response with the new event" do
        post :create, params: { data: valid_attributes }
        expect(response).to be_successful
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new event" do
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
          types: 'events',
          id: event.to_param,
          attributes: {
            name: 'FOO'
          }
        }
      end

      let(:invalid_attributes) do
        {
          types: 'events',
          id: event.to_param,
          attributes: {
            name: ''
          }
        }
      end

      it "updates the requested event" do
        expect {
          put :update, params: { id: event.to_param, data: new_attributes }
        }.to change { event.reload.name }.to 'FOO'
      end

      it "renders a JSON response with the event" do
        put :update, params: { id: event.to_param, event: valid_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/vnd.api+json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the event" do
        put :update, params: { id: event.to_param, data: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/vnd.api+json')
      end
    end
  end

  describe "DELETE #destroy" do
    before(:each) { event }

    it "is successful" do
      delete :destroy, params: { id: event.to_param }
      expect(response).to be_successful
    end

    it "destroys the requested event" do
      expect {
        delete :destroy, params: { id: event.to_param }
      }.to change(Event, :count).by(-1)
    end
  end

end
