class EndorsementPath
  attr_reader :id, :topic, :path, :endorser, :endorsee, :description

  def initialize(endorsement, path)
    @id = SecureRandom.hex(2)
    @topic = endorsement.topic
    @endorser = endorsement.endorser
    @endorsee = endorsement.endorsee
    @description = endorsement.description
    @path = path
  end
end
