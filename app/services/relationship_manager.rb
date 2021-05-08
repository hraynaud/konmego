class RelationshipManager

  def self.create_friendship_if_none_exists_for(endorsement)
    endorser = endorsement.endorser
    endorsee = endorsement.endorsee

    befriend(endorser, endorsee)
    follow(endorser, endorsee)
  end


  def self.follow follower, followed
    follower.followings << followed
  end

  def self.befriend endorser, endorsee
    return if endorsee.friends_with?(endorser)
    endorser.contacts << endorsee
  end

  def self.block follower, followed
    #TODO 
  end

end
