module KonmegoNeo4jNode
  extend ActiveSupport::Concern

  included do

    include ActiveGraph::Node
    include ActiveGraph::Timestamps::Created
    #include ActiveGraph::Timestamps::Updated NOTE this causes weird test failures
    scope :by_created, -> { order(created_at: :asc) }
    scope :first, -> { by_created.first }
    scope :last, -> { by_created.last }

    def type
      self.class.name
    end
  end

end
