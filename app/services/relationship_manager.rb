class RelationshipManager

  def self.create_friendship_if_none_exists_for(endorsement)
    endorser = endorsement.from_node
    endorsee = endorsement.to_node
    edorsee.status = "member" if endorsee.status == "non_member"

    befriend(endorser, endorsee)
    #Dsiable following for now : 01/03/23
    # follow(endorser, endorsee)
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

  def self.connections person
    OpenStruct.new(
      friends: person.friends.map(&:extract),
      followers: person.followers.map(&:extract), 
      followings: person.followings.map(&:extract)
    )
  end

end
