module Podcast
  class FeedSerializer < ActiveModel::Serializer
    attributes :id, :url
  end
end
