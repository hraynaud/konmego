class Project 
  include KonmegoNeo4jNode
  property :name, type: String
  property :description, type: String
  property :start_date, type: Date
  property :end_date, type: Date

  enum status: [:inactive, :active, :canceled, :failed], _default: :inactive
  enum visibility: [:private, :friends, :in_network, :vendor, :public], _default: :private

  has_one :in, :owner, type: :OWNS, model_class: :Person
  has_one :out, :topic, type: :CONCERNS
  has_many :out,:obstacles, type: :BLOCKS, model_class: :Obstacle
  has_many :in, :participants, type: :PARTICIPATES_IN, model_class: :Person

  validates :owner, :name, :description, presence: true
  validates :topic, presence: {message: "Projects must have a topic"}
  validates :obstacles, presence: {message: "At least one obstacle required"}, on: :update

  def topic_name
    topic.name
  end

  def as_json options = nil
    super(root: false, except: [:neo_id, :visibility ])
  end

  class << self
    def default_scope person
       person.projects.public_projects


         # Project.where(owner_id: person_id)
      # .or person_id in participants.map(&;id)
      # .or owner.friends.include(person_id) && visibility == friends
      # .or owner.contacts_at_dept(3).map(&id).includes(person_id) && visibility
      # = in_network
      # or visibility == :public
      #
    end 


    def public_projects
      by_visibilty(:public)
    end

    def active_projects
      by_status(:active)
    end

    def by_topic topic_id
      where.topic(id: topic_id)
    end
   
    def private_projects
      by_visibilty :private
    end

    def by_visibilty viz
      Project.where(visibility: Project.visibilities[viz])
    end

    def by_status status
      Project.where(status: Project.statuses[status])
    end

  end

end

