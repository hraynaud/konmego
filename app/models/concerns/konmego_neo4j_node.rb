module KonmegoNeo4jNode
  extend ActiveSupport::Concern

  included do

    include ActiveGraph::Node

    def type
      self.class.name
    end
  end

end
