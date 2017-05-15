require "rails_helper"

RSpec.describe AuthenticationMailer, type: :mailer do
  describe "sign_in" do
    let(:user) { FactoryGirl.create :user }
    let(:token) { AuthenticationService.new(user).create_token }
    let(:mail) { AuthenticationMailer.sign_in(user.email, token) }

    it "renders the subject" do
      expect(mail.subject).to eq("Sign in to emberwatch.com")
    end

    it "sends the mail to the user" do
      expect(mail.to).to eq([user.email])
    end

    it "contains the token" do
      expect(mail.body.encoded).to include(token)
    end
  end

end
