require 'base64'

class Endorse
  include ActiveGraph::Relationship

  from_class :Person
  to_class   :Person
  type 'ENDORSES'
  creates_unique on: [:topic]

  property :topic
  property :topic_id
  property :topic_image
  property :description
  property :path
  enum status: [:pending, :accepted, :declined], _default: :pending, _index: false
  enum topic_status: [:proposed, :existing], _default: :proposed

  validates_presence_of :topic


  class << self
    def pending
      statuses.keys[0]
    end

    def accepted
      statuses.keys[1]
    end

    def declined
      statuses.keys[2]
    end

    def decode_id id
      Base64.urlsafe_decode64(id)
    end
  end
  
  def accept!
    self.status = :accepted
    save
  end

  def decline!
    self.status = :declined
    save
  end

  def destroy!
   
    save
  end
  
  def endorser_avatar_url
    from_node.avatar_url
  end

  def endorsee_avatar_url
    to_node.avatar_url
  end

  def endorsee_name
    to_node.name
  end

  def endorser_name
    from_node.name
  end

  def endorsee_id
    to_node.id
  end

  def endorser_id
    from_node.id
  end

  def endorser
    from_node
  end 

  def endorsee
    to_node
  end 

  def id
    EndorsementService.generate_id(endorser_id,endorsee_id,topic)
  end

  def obfuscate type="all"
    case type  
      when "all"
        puts "all"
      when "from"
        puts "from"
      when "to"
        puts "to"
    end
  end

end
