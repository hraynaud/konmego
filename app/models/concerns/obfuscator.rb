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

  def self.wrapped_endorsement endorsement
    WrappedEndorsement.new(endorser: endorsement.endorser, endorsee: endorsement.endorsee)
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

  def self.wrapped_person node, role
    WrappedPerson.new(first_name: node.first_name, last_name: node.last_name,
                      avatar_url: node.avatar_url, profile_image_url: node.profile_image_url, role: role)
  end

  def self.obfuscated_person role
    WrappedPerson.new(first_name: HIDDEN, last_name: HIDDEN, avatar_url: nil, profile_image_url: nil, role: role)
  end

end
