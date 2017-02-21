class PersonSerializer < ActiveModel::Serializer
  attributes :id,
    :old_id,
    :shortname,
    :name,
    :github,
    :slack,
    :twitter,
    :slideshare,
    :speakerdeck,
    :site,
    :company
end
