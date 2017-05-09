require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should have_db_column(:date) }
  it { should have_db_column(:name) }
  it { should have_db_column(:site) }
  it { should have_db_column(:created_at) }
  it { should have_db_column(:updated_at) }

  it 'is valid' do
    event = FactoryGirl.build(:event)
    expect(event).to be_valid
  end
end
