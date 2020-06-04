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
    @obfuscated_endorsement = Obfuscation::EndorsementObfuscator.obfuscate(@user, @endorsement)
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
      return extract_node node, role 
    else
      return handle_non_current_user node, role
    end
  end

  def extract_node node, role
    person = node.extract
    person.role = role
    person
  end

  def is_current_user? node
    node === @user
  end

  def handle_non_current_user node, role
    return @user.friends_with?(node) ? extract_node(node, role) : Obfuscation::PersonObfuscator.obfuscate(role)
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
