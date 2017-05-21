module Podcast
  class Feed < ApplicationRecord
    validates :url, presence: true, uniqueness: { case_sensitive: false }
  end
end
