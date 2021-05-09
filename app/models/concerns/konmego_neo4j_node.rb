module KonmegoNeo4jNode
  extend ActiveSupport::Concern

  included do

    include ActiveGraph::Node
    include ActiveGraph::Timestamps

    def type
      self.class.name
    end
  end

end
