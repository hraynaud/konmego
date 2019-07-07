class EndorsementService

  def self.for_existing_person endorser, endorsee, topic
    endorsement = Endorsement.new
    endorsement.endorser = endorser
    endorsement.endorsee = endorsee
    endorsement.topic = topic 
    endorsement.save
  end

  def self.for_new_person endorser, endorsee, topic
    endorsement = Endorsement.new
    endorsement.endorser = endorser
    endorsement.endorsee = endorsee
    endorsement.topic = topic 
    endorsement.save
  end

end
