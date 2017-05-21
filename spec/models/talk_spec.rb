require 'rails_helper'

RSpec.describe Talk, type: :model do
  it { should have_db_column(:title) }
  it { should have_db_column(:subtitle) }
  it { should have_db_column(:videos) }
  it { should have_db_column(:url) }
  it { should have_db_column(:slides) }
  it { should have_db_column(:date) }
  it { should have_db_column(:created_at) }
  it { should have_db_column(:updated_at) }

  it { should validate_presence_of :title }

  it 'is valid' do
    talk = FactoryGirl.build(:talk)
    expect(talk).to be_valid
  end
end
