class Obfuscator

  HIDDEN = "Hidden"

  WrappedPerson = Struct.new(:first_name, :last_name, :avatar_url, :profile_image_url, :role , keyword_init: true) do
    def name 
      "#{first_name} #{last_name}"
    end
  end

  WrappedEndorsement = Struct.new(:endorser, :endorsee,  keyword_init: true) do
    def name 
      "#{first_name} #{last_name}"
    end
  end

  def initialize user, endorser, endorsee
    @user = user
    @endorser = endorser
    @endorsee = endorsee
  end

  def obfuscate node

    if node.is_a? Person
      if node === @user
        return wrapped_person(node,role(node))
      else

        return @user.friends_with?(node) ? wrapped_person(node,role(node)) : obfuscated_person(role(node))
      end
    end
  end

  def role person
    case 
    when person == @endorser
      "endorser"
    when person == @endorsee
      "endorsee"
    else
      "contact"
    end
  end

  def friends_with_both? endorsement
    @user.friends_with? endorsement.endorsee and @user.friends_with? endorsement.endorser 
  end

  def wrapped_person node, role
    WrappedPerson.new(first_name: node.first_name, last_name: node.last_name,
                      avatar_url: node.avatar_url, profile_image_url: node.profile_image_url, role: role)
  end

  def obfuscated_person role
    WrappedPerson.new(first_name: HIDDEN, last_name: HIDDEN, avatar_url: nil, profile_image_url: nil, role: role)
  end

end
