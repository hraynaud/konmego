class PathExtractor
  attr_reader :path, :obfuscated_endorsement

  def initialize user, path, endorsement
    @user = user
    @endorsement = endorsement
    @endorser = endorsement.from_node
    @endorsee = endorsement.to_node
    @path = path
  end

  def extract
    path.map do |node|
      

      {
        name: node.name,
        avatar_url: node.avatar_url,
        id: node.id,
        role: get_role(node),
        is_visible: can_show?(node)
      }
      
    end
  end

  private

  def can_show? node
    node == @user || node.friends_with?(@user)
  end

  def is_current_user? node
    node === @user
  end

  def get_role person
    case 
    when person == @endorser
      "endorser"
    when person == @endorsee
      "endorsee"
    when person == @user
      "me"
    else
      "contact"
    end
  end
end
