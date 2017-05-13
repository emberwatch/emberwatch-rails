require 'rails_helper'

RSpec.describe Api::BaseController, type: :controller do
  it { should respond_to :current_user }
end
