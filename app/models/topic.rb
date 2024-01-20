class Topic
  include KonmegoNeo4jNode

  property :category, type: String
  property :name, type: String
  property :default_image_file, type: String
  property :icon, type: String
  validates :name, presence: true

  has_many :in, :endorsements, origin: :topic
  has_many :in, :projects, origin: :CONCERNS
end
