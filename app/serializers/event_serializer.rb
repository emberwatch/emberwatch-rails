class EventSerializer < ActiveModel::Serializer
  attributes :id,
    :date, :name, :site, :created_at, :updated_at
end
