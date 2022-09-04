class EndorsementSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower
  attributes :uuid, :neo_id, :description, :status
  attribute :topic do |o|
    o.topic.name
  end
  attribute :topic_id do |o|
    o.topic.id
  end
end
