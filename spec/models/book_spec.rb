require 'rails_helper'

RSpec.describe Book, type: :model do
  it { should have_db_column(:title) }
  it { should have_db_column(:publisher) }
  it { should have_db_column(:url) }
  it { should have_db_column(:payment) }
  it { should have_db_column(:created_at) }
  it { should have_db_column(:updated_at) }

  it { should validate_presence_of :title }

  it 'is valid' do
    book = FactoryGirl.build(:book)
    expect(book).to be_valid
  end
end
