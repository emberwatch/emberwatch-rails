class ScreencastSerializer < ActiveModel::Serializer
  attributes :id,
    :title,
    :url,
    :date,
    :videos,
    :series,
    :price,
    :subtitle
end
