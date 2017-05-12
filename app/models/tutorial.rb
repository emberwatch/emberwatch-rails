class Tutorial < ApplicationRecord
  serialize :versions, Hash
  serialize :urls, Array

  validates :title, presence: true
end
