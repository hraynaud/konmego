class Topic
  include KonmegoNeo4jNode

  property :name, type: String
  property :default_image_file, type: String
  property :icon, type: String
  property :categories, default: []

  validates :name, presence: true
  has_many :in, :endorsements, origin: :topic
  has_many :in, :projects, origin: :CONCERNS

  before_save :de_dup_categories

  private
  
  def de_dup_categories
    self.categories = categories.uniq
  end
end
