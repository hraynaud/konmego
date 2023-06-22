class EndorsementSerializer
  include ::JSONAPI::Serializer
  set_key_transform :camel_lower
  attributes :description, :status, :topic_image, :endorsee_id, :endorser_id, :endorser_name, :endorsee_name,:endorser_avatar_url, :endorsee_avatar_url,:topic_id

 

  # attribute :endorsements do |p, params|
  #   p.endorsements(:friend,:rel).pluck(:friend,:rel).map do |friend, rel|
  #    dir = rel.from_node.id == p.id ? "out" : "in"
  #    {
  #      dir: dir,
  #      first_name: friend.first_name,
  #      last_name: friend.last_name,
  #      avatar_url: friend.avatar_url,
  #      id: friend.id,
  #      topic: rel.topic,
  #      description: rel.description
  #    }
  #  end

  # end
end
