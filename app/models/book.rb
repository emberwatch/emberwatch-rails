class Book < ApplicationRecord
  #
  # has_many :author

  validates :title, presence: true
end
