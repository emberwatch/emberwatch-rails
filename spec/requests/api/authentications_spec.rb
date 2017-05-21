require 'rails_helper'

RSpec.describe "Api::Talks", type: :request do
  describe '#create' do
    it 'is successful', doc: true do
      attributes = { email: 'foo@bar.baz' }
      post api_authentications_path, params: attributes, headers: headers
      expect(response).to be_successful
    end

    it 'is unprocessable with invalid data', doc: true do
      attributes = { }
      post api_authentications_path, params: attributes, headers: headers
      expect(response).to be_unprocessable
    end
  end
end
