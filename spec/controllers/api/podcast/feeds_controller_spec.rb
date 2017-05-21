require 'rails_helper'

RSpec.describe Api::Podcast::FeedsController, type: :controller do
  let(:valid_attributes) do
    {
      type: 'podcast/feeds',
      attributes: FactoryGirl.attributes_for(:podcast_feed)
    }
  end

  let(:invalid_attributes) do
    {
      type: 'podcast/feeds',
      attributes: FactoryGirl.attributes_for(:podcast_feed, url: '')
    }
  end

  let(:admin) { FactoryGirl.create(:admin) }
  let(:podcast_feed) { FactoryGirl.create(:podcast_feed) }

  before :each do
    allow_any_instance_of(described_class).to receive(:current_user).and_return(admin)
  end

  describe "GET #index" do
    before(:each) { podcast_feed }

    it "returns a success response" do
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: podcast_feed.to_param }
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Api::Podcast::Feed" do
        expect {
          post :create, params: { data: valid_attributes }
        }.to change(Podcast::Feed, :count).by(1)
      end

      it "renders a JSON response with the new podcast_feed" do
        post :create, params: { data: valid_attributes }
        expect(response).to be_successful
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new podcast_feed" do
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
          types: 'podcast_feeds',
          id: podcast_feed.to_param,
          attributes: {
            url: 'http://example.com/feed'
          }
        }
      end

      let(:invalid_attributes) do
        {
          types: 'podcast_feeds',
          id: podcast_feed.to_param,
          attributes: {
            url: ''
          }
        }
      end

      it "updates the requested podcast_feed" do
        expect {
          put :update, params: { id: podcast_feed.to_param, data: new_attributes }
        }.to change { podcast_feed.reload.url }.to 'http://example.com/feed'
      end

      it "renders a JSON response with the podcast_feed" do
        put :update, params: { id: podcast_feed.to_param, podcast_feed: valid_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/vnd.api+json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the podcast_feed" do
        put :update, params: { id: podcast_feed.to_param, data: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/vnd.api+json')
      end
    end
  end

  describe "DELETE #destroy" do
    before(:each) { podcast_feed }

    it "is successful" do
      delete :destroy, params: { id: podcast_feed.to_param }
      expect(response).to be_successful
    end

    it "destroys the requested podcast_feed" do
      expect {
        delete :destroy, params: { id: podcast_feed.to_param }
      }.to change(Podcast::Feed, :count).by(-1)
    end
  end

end
