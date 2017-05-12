require 'rails_helper'

RSpec.describe Api::PeopleController, type: :controller do
  let(:valid_attributes) do
    {
      type: 'people',
      attributes: FactoryGirl.attributes_for(:person)
    }
  end

  let(:invalid_attributes) do
    {
      type: 'people',
      attributes: FactoryGirl.attributes_for(:person, name: '')
    }
  end

  let(:admin) { FactoryGirl.create(:admin) }
  let(:person) { FactoryGirl.create(:person) }

  before :each do
    allow_any_instance_of(described_class).to receive(:current_user).and_return(admin)
  end

  describe "GET #index" do
    before(:each) { person }

    it "returns a success response" do
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: person.to_param }
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Api::Person" do
        expect {
          post :create, params: { data: valid_attributes }
        }.to change(Person, :count).by(1)
      end

      it "renders a JSON response with the new person" do
        post :create, params: { data: valid_attributes }
        expect(response).to be_successful
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new person" do
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
          types: 'people',
          id: person.to_param,
          attributes: {
            name: 'FOO'
          }
        }
      end

      let(:invalid_attributes) do
        {
          types: 'people',
          id: person.to_param,
          attributes: {
            name: ''
          }
        }
      end

      it "updates the requested person" do
        expect {
          put :update, params: { id: person.to_param, data: new_attributes }
        }.to change { person.reload.name }.to 'FOO'
      end

      it "renders a JSON response with the person" do
        put :update, params: { id: person.to_param, person: valid_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/vnd.api+json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the person" do
        put :update, params: { id: person.to_param, data: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/vnd.api+json')
      end
    end
  end

  describe "DELETE #destroy" do
    before(:each) { person }

    it "is successful" do
      delete :destroy, params: { id: person.to_param }
      expect(response).to be_successful
    end

    it "destroys the requested person" do
      expect {
        delete :destroy, params: { id: person.to_param }
      }.to change(Person, :count).by(-1)
    end
  end

end
