class PathExtractor
  attr_reader :path, :obfuscated_endorsement

  def initialize user, people
    @user = user
    @endorser = people.endorser
    @endorsee = people.endorsee
    @endorsement = people.e
    obfuscate people.full_path
  end

  def obfuscate full_path
    @path =  process_path full_path
    @obfuscated_endorsement = Obfuscation::EndorsementObfuscator.do_partial(@endorsement)
  end

  private

  def process_path path
    path.map do |node|
      handle_person(node)
    end
  end

  def handle_person node
    role = get_role(node) 

    if is_current_user? node
      return Obfuscation::PersonObfuscator.do_partial node,role
    else
      return handle_non_current_user node, role
    end
  end

  def is_current_user? node
    node === @user
  end

  def handle_non_current_user node, role
    return @user.friends_with?(node) ? Obfuscation::PersonObfuscator.do_partial(node,role) : Obfuscation::PersonObfuscator.do_total(role)
  end

  def get_role person
    case 
    when person == @endorser
      "endorser"
    when person == @endorsee
      "endorsee"
    else
      "contact"
    end
  end
end
