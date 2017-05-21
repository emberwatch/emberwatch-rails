require 'rails_helper'

RSpec.describe Podcast::Feed, type: :model do
  it { should have_db_column(:url) }
  it { should have_db_column(:created_at) }
  it { should have_db_column(:updated_at) }

  it { should validate_presence_of :url }
  it { should validate_uniqueness_of(:url).case_insensitive }
end
