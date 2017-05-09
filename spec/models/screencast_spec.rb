require 'rails_helper'

RSpec.describe Screencast, type: :model do
  it { should have_db_column(:title) }
  it { should have_db_column(:url) }
  it { should have_db_column(:date) }
  it { should have_db_column(:videos) }
  it { should have_db_column(:series) }
  it { should have_db_column(:price) }
  it { should have_db_column(:subtitle) }
  it { should have_db_column(:created_at) }
  it { should have_db_column(:updated_at) }

  it 'is valid' do
    screencast = FactoryGirl.build(:screencast)
    expect(screencast).to be_valid
  end
end
