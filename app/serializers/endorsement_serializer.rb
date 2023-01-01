class EndorsementSerializer
  include ::JSONAPI::Serializer
  set_key_transform :camel_lower
  attributes :description, :status, :topic_image, :endorser_avatar_url, :endorsee_avatar_url,:topic_id

  attribute :direction, if: Proc.new {|o, params|
    params && params[:ref_user]} do |o, params|
      o.direction_from_person(params[:ref_user])
    end 

end
