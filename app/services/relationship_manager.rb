class RelationshipManager

  def self.create_friendship_if_none_exists_for(endorsement)
    endorser = endorsement.endorser
    endorsee = endorsement.endorsee

    befriend(endorser, endorsee)
    follow(endorser, endorsee)
  end

  def self.create_placeholder_member_if_not_on_konnosaurus(endorsement)
    if endorsement.endorsee.nil? && endorsement.non_member_email.present?\
        && endorsement.non_member_fname.present?  && endorsement.non_member_lname.present?

      endorsement.endorsee = User.create_non_member_if_new_email(
        :email => endorsement.non_member_email, 
        :first_name=>endorsement.non_member_fname,
        :last_name=>endorsement.non_member_lname,
        :password=>"K2kM7y$2#0",
        :is_member => false)
    end
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
