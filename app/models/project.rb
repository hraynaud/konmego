class Project
  include KonmegoNeo4jNode
  property :name, type: String
  property :description, type: String
  property :start_date, type: Date
  property :deadline, type: Date
  property :icon, type: String
  property :progress
  property :open_items
  property :roadblocks
  property :tags
  property :comments
  property :hero_image_url, type: String

  enum status: %i[pending paused inactive active canceled failed], _default: :inactive
  enum visibility: %i[private friends in_network vendor public], _default: :private

  has_one :in, :owner, type: :OWNS, model_class: :Person
  has_one :out, :topic, type: :CONCERNS

  has_many :in, :participants, type: :PARTICIPATES_IN, model_class: :Person
  has_many :in, :posts, type: nil

  validates :owner, :name, :description, presence: true
  # validates :topic, presence: {message: "Projects must have a topic"}

  validate :cannot_set_status_active_without_required_attributes_set, on: :update

  scope :public, -> { where('projects.visibility > ? ', Project.visibilities[:public]) }

  def topic_name
    topic.try(:name)
  end

  def topic_image
    topic.try(:default_image_file)
  end

  def as_json(_options = nil)
    super(root: false, except: %i[neo_id visibility])
  end

  class << self
    def default_scope(person)
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

    def by_topic(topic_id)
      where.topic(id: topic_id)
    end

    def private_projects
      by_visibilty :private
    end

    def by_visibilty(viz)
      Project.where(visibility: Project.visibilities[viz])
    end

    def by_status(status)
      Project.where(status: Project.statuses[status])
    end
  end

  private

  def cannot_set_status_active_without_required_attributes_set
    return unless status == 'active' and invalid_activation_config?

    errors.add(:status,
               'Cannot activate project without obstacles, topics, description, start date and deadline and visibility')
  end

  def invalid_activation_config?
    topic.nil? || description.blank? || start_date.nil? || deadline.nil?
  end
end
