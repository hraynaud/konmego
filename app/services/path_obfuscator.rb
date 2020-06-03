class PathObfuscator
  attr_reader :obfuscated_path, :obfuscated_endorsement

  def initialize user, path
    @user = user
    @path = path
    @endorser = path.endorser
    @endorsee = path.endorsee
    @endorsement = path.e
  end

  def obfuscate
    @obfuscated_path =  @path.full_path.map do |node|
      for_person(node)
    end
    @obfuscated_endorsement = Obfuscator.wrapped_endorsement(@endorsement)
  end


  def for_person node
    if node === @user
      return Obfuscator.wrapped_person(node,role(node))
    else
      return @user.friends_with?(node) ? Obfuscator.wrapped_person(node,role(node)) : Obfuscator.obfuscated_person(role(node))
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

  def friends_with_both? 
    @user.friends_with? @endorsee and @user.friends_with? @endorser 
  end

end
