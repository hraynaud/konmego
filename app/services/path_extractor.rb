class PathExtractor
  attr_reader :path, :obfuscated_endorsement

  def initialize(user, record)
    @user = user
    @endorser = record[:endorser]
    @endorsee = record[:endorsee]
    @endorsement = record[:e]
    obfuscate record[:full_path]
  end

  def obfuscate(full_path)
    @path = process_path full_path
    binding.pry
    @obfuscated_endorsement = Obfuscation::EndorsementObfuscator.obfuscate(@user, @endorsement)
  end

  private

  def process_path(path)
    path.map do |node|
      handle_person(node)
    end
  end

  def handle_person(node)
    role = get_role(node)
    return extract_node node, role if is_current_user? node

    handle_non_current_user node, role
  end

  def extract_node(node, role)
    add_role(node.extract, role)
  end

  def is_current_user?(node)
    node === @user
  end

  def handle_non_current_user(node, role)
    if @user.friends_with?(node)
      extract_node(node, role)
    else
      add_role(Obfuscation::PersonObfuscator.obfuscate(node), role)
    end
  end

  def add_role(person, role)
    person.role = role
    person
  end

  def get_role(person)
    if person == @endorser
      'endorser'
    elsif person == @endorsee
      'endorsee'
    else
      'contact'
    end
  end
end
