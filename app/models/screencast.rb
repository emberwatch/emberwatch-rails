class Screencast < ApplicationRecord
  serialize :videos, Array

  validates :title, presence: true
end
