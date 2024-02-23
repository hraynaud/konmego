class EndorsementGraphProcessor
  class << self
    def process(current_user, graph_data)
      path_data = graph_data.pluck(:e, :all_paths)
      process_and_obfuscate_paths(current_user, path_data)
    end

    private

    def process_and_obfuscate_paths(person, path_data)
      path_data.map do |endorsement, path|
        # _endorsers = person.endorsers # NOTE: important need call endorsers on person to lazy load associations
        @path_processor = PathProcessor.new(person, path, endorsement)
        EndorsementPath.new(endorsement, @path_processor.obfuscate)
      end
    end
  end

  class PathProcessor
    attr_reader :path, :processed_path, :obfuscated_path

    def initialize(user, path, endorsement)
      @user = user
      @endorsement = endorsement
      @endorser = endorsement.endorser
      @endorsee = endorsement.endorsee
      @path = path
    end

    def process
      path.map do |node|
        {
          name: node.first_name,
          avatar_url: node.avatar_url,
          id: node.id,
          role: get_role(node),
          is_visible: can_show?(node)
        }
      end
    end

    def obfuscate
      process.each do |node|
        if node[:is_visible]
          node
        else
          node.tap do |n|
            n[:id] = '000'
            n[:name] = 'Anonymous'
            n[:avatar_url] = 'anonymous.png'
          end
        end
      end
    end

    private

    def can_show?(node)
      node == @user || node.friends_with?(@user)
    end

    def is_current_user?(node)
      node === @user # rubocop:disable Style/CaseEquality
    end

    def get_role(person)
      if person == @endorser
        'endorser'
      elsif person == @endorsee
        'endorsee'
      elsif person == @user
        'me'
      else
        'contact'
      end
    end
  end
end
