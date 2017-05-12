require 'rails_helper'

RSpec.describe Person, type: :model do
  it { should have_db_column(:old_id) }
  it { should have_db_column(:shortname) }
  it { should have_db_column(:name) }
  it { should have_db_column(:github) }
  it { should have_db_column(:slack) }
  it { should have_db_column(:twitter) }
  it { should have_db_column(:slideshare) }
  it { should have_db_column(:speakerdeck) }
  it { should have_db_column(:site) }
  it { should have_db_column(:company) }
  it { should have_db_column(:created_at) }
  it { should have_db_column(:updated_at) }

  it { should validate_presence_of :name }

  it 'is valid' do
    person = FactoryGirl.build(:person)
    expect(person).to be_valid
  end
end
