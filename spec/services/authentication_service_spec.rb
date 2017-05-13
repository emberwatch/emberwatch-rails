require 'rails_helper'

RSpec.describe AuthenticationService, type: :service do

  subject { described_class.new(user) }

  let(:user) { FactoryGirl.create :user }

  it { should respond_to :user }
  it { should respond_to :create_token }

  describe '#create_token' do
    it 'returns a string' do
      expect(subject.create_token).to be_a String
    end

    it 'is a valid JWT' do
      token  = subject.create_token
      secret = Rails.application.secrets.secret_key_base
      expect {
        JWT.decode token, secret, 'HS256'
      }.to_not raise_error
    end

    it 'expires the token in one day' do
      token  = subject.create_token
      secret = Rails.application.secrets.secret_key_base
      Timecop.freeze(2.days.from_now) do
        expect {
          JWT.decode token, secret, 'HS256'
        }.to raise_error(JWT::ExpiredSignature)
      end
    end
  end

  describe 'the class' do
    subject { described_class }

    it { should respond_to :validate_token }

    context 'with a valid token' do
      it 'returns an User' do
        token  = subject.new(user).create_token
        result = subject.validate_token(token)
        expect(result).to be_a User
      end
    end

    context 'with invalid token' do
      it 'returns nil' do
        result = subject.validate_token('')
        expect(result).to be_nil
      end
    end

    context 'with expired token' do
      it 'returns nil' do
        token = subject.new(user).create_token
        Timecop.freeze(2.days.from_now) do
          result = subject.validate_token(token)
          expect(result).to be_nil
        end
      end
    end

    context 'with missing user' do
      it 'returns nil' do
        user = FactoryGirl.build(:user)
        token = subject.new(user).create_token
        result = subject.validate_token(token)
        expect(result).to be_nil
      end
    end

    context 'with invalid secret' do
      it 'returns nil' do
        payload = {}
        token = JWT.encode payload, '123', 'HS256'
        result = subject.validate_token(token)
        expect(result).to be_nil
      end
    end
  end
end
