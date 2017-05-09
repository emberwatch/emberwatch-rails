require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  it { should have_db_column(:title) }
  it { should have_db_column(:urls) }
  it { should have_db_column(:date) }
  it { should have_db_column(:code) }
  it { should have_db_column(:date_updated) }
  it { should have_db_column(:date_created) }
  it { should have_db_column(:versions) }
  it { should have_db_column(:demo) }
  it { should have_db_column(:created_at) }
  it { should have_db_column(:updated_at) }

  it 'is valid' do
    tutorial = FactoryGirl.build(:tutorial)
    expect(tutorial).to be_valid
  end
end
