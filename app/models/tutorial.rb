class Tutorial < ApplicationRecord
  serialize :versions, Hash
  serialize :urls, Array
end
