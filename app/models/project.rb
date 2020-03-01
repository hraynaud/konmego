class Project 
  include KonmegoNeo4jNode
  property :name, type: String
  property :description, type: String
  property :start_date, type: Date
  property :end_date, type: Date

  enum status: [:inactive, :active, :canceled, :failed], _default: :inactive
  enum visibility: [:private, :friends, :in_network, :vendor, :public], _default: :private

  has_one :in, :owner, model_class: :Person, type: :OWNS
  has_one :out, :topic, type: :CONCERNS
  has_many :out,:obstacles, type: :PREVENTS, model_class: :Obstacle
  has_many :in, :contributors, type: :CONTRIBUTES, model_class: :Person

  validates :owner, :name, :description, presence: true
  validates :topic, presence: {message: "Projects must have a topic"}
  validates :obstacles, presence: {message: "At least one obstacle required"}, on: :update

  def as_json options = nil
    super(root: false, except: [:neo_id, :visibility ])
  end
end

