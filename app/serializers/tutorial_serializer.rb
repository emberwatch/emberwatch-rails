class TutorialSerializer < ActiveModel::Serializer
  attributes :id,
    :title,
    :urls,
    :date,
    :code,
    :date_updated,
    :date_created,
    :versions,
    :demo
end
