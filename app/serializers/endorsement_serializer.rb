class EndorsementSerializer
  include ::JSONAPI::Serializer
  set_key_transform :camel_lower
  attributes :description, :status, :topic, :topic_image, :endorsee_id, :endorser_id, :endorser_name, :endorsee_name,:endorser_avatar_url, :endorsee_avatar_url,:topic_id


end
