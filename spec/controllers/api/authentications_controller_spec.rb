require 'rails_helper'

RSpec.describe Api::AuthenticationsController, type: :controller do
  let(:valid_attributes) do
    {
      email: 'foo@bar.baz'
    }
  end

  let(:invalid_attributes) do
    { }
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new user if not available yet" do
        expect {
          post :create, params: valid_attributes
        }.to change(User, :count).by(1)
      end

      it "is not creating a user if already available" do
        FactoryGirl.create :user, email: valid_attributes[:email]
        expect {
          post :create, params: valid_attributes
        }.to_not change(User, :count)
      end

      it "is successful" do
        post :create, params: valid_attributes
        expect(response).to be_successful
      end

      it "sends an email to the given email with an authenticato token" do
        mailer = double(:deliver_now)
        allow_any_instance_of(AuthenticationService).to receive(:create_token)
          .and_return('foo')
        expect(AuthenticationMailer).to receive(:sign_in)
          .with(valid_attributes[:email], 'foo')
          .and_return(mailer)
        expect(mailer).to receive(:deliver_now)
        post :create, params: valid_attributes
      end

      it "sends a JWT for the given user" do
        allow(AuthenticationMailer).to receive(:sign_in) do |email, token|
          secret  = Rails.application.secrets.secret_key_base
          data, _ = JWT.decode token, secret, 'HS256'
          expect(data['eml']).to eql valid_attributes[:email]
          double(deliver_now: true)
        end
        post :create, params: valid_attributes
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors" do
        post :create, params: invalid_attributes
        expect(response).to be_unprocessable
        expect(response.content_type).to eq('application/vnd.api+json')
      end
    end
  end
end
