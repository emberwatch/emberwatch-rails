class TalkSerializer < ActiveModel::Serializer
  attributes :id,
    :title,
    :subtitle,
    :videos,
    :url,
    :slides,
    :date
end
