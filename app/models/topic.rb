class Topic

  include KonmegoNeo4jNode

  property :category, type: String
  property :name, type: String
  validates :name, presence: true

  has_many :in, :endorsements, origin: :topic
  has_many :in, :projects, origin: :CONCERNS

end
