module KonmegoNeo4jNode
  extend ActiveSupport::Concern

  included do

    include ActiveGraph::Node
    include ActiveGraph::Timestamps::Created
    #include ActiveGraph::Timestamps::Updated NOTE this causes weird test failures

    def type
      self.class.name
    end
  end

end
