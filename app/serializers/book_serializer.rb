class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :publisher, :url, :payment
end
