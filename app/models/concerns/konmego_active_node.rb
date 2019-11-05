module KonmegoActiveNode
  extend ActiveSupport::Concern

  included do

    include Neo4j::ActiveNode

    def type
      self.class.name
    end
  end

end
