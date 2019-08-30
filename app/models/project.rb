class Project 
  include Neo4j::ActiveNode

  property :name, type: String
  property :description, type: String
  property :start_date, type: Date
  property :end_date, type: Date

  enum status: [:inactive, :active, :canceled, :failed], _default: :inactive
  enum visibility: [:private, :friends, :in_network, :vendor, :public], _default: :friends

  has_one :in, :owner, model_class: :Person, type: :OWNS
  has_one :out, :topic, type: :CONCERNS
  has_many :out,:success_criteria, type: :NEEDS, model_class: :SuccessCriterium
  has_many :in, :contributors, type: :CONTRIBUTES, model_class: :Person

  validates :owner, :name, :description, presence: true
  validates :topic, presence: {message: "Projects must have a topic"}
  validates :success_criteria, presence: {message: "At least one success criteria required"}, on: :update

end

