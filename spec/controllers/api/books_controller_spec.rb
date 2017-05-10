require 'rails_helper'

RSpec.describe Api::BooksController, type: :controller do
  let(:valid_attributes) do
    {
      type: 'books',
      attributes: FactoryGirl.attributes_for(:book)
    }
  end

  let(:invalid_attributes) do
    {
      type: 'books',
      attributes: FactoryGirl.attributes_for(:book, title: '')
    }
  end

  let(:admin) { FactoryGirl.create(:admin) }
  let(:book) { FactoryGirl.create(:book) }

  before :each do
    allow_any_instance_of(described_class).to receive(:current_user).and_return(admin)
  end

  describe "GET #index" do
    before(:each) { book }

    it "returns a success response" do
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: book.to_param }
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Api::Book" do
        expect {
          post :create, params: { data: valid_attributes }
        }.to change(Book, :count).by(1)
      end

      it "renders a JSON response with the new book" do
        post :create, params: { data: valid_attributes }
        expect(response).to be_successful
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new book" do
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
          types: 'books',
          id: book.to_param,
          attributes: {
            title: 'FOO'
          }
        }
      end

      let(:invalid_attributes) do
        {
          types: 'books',
          id: book.to_param,
          attributes: {
            title: ''
          }
        }
      end

      it "updates the requested book" do
        expect {
          put :update, params: { id: book.to_param, data: new_attributes }
        }.to change { book.reload.title }.to 'FOO'
      end

      it "renders a JSON response with the book" do
        put :update, params: { id: book.to_param, book: valid_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/vnd.api+json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the book" do
        put :update, params: { id: book.to_param, data: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/vnd.api+json')
      end
    end
  end

  describe "DELETE #destroy" do
    before(:each) { book }

    it "is successful" do
      delete :destroy, params: { id: book.to_param }
      expect(response).to be_successful
    end

    it "destroys the requested book" do
      expect {
        delete :destroy, params: { id: book.to_param }
      }.to change(Book, :count).by(-1)
    end
  end

end
