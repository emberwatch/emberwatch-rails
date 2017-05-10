class User < ApplicationRecord
  rolify

  validates :email, presence: true, uniqueness: { case_sensitive: false }
end
