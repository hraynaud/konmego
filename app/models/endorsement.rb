class Endorsement

  include Neo4j::ActiveNode

  has_one :out, :endorser, type: :ENDORSEMENT_SOURCE, model_class: :Person
  has_one :out, :endorsee, type: :ENDORSEMENT_TARGET, model_class: :Person
  has_one :out, :topic, type: :ENDORSE_TOPIC

  property :description
  enum status: [:pending, :accepted, :declined], _default: :pending

  before_create :add_description

  validates :endorsee, :endorser, :topic, presence: true
  validate :is_unique_across_endorser_endorsee_and_topic, on: :create

  scope :accepted,  ->{where(status: :accepted)}
  private

  def add_description
    self.description = "#{endorser.name} Endorses someone for #{topic.name}"
  end

  def is_unique_across_endorser_endorsee_and_topic
    if Endorsement.where(endorser: endorser, endorsee: endorsee, topic: topic).any?
      errors.add(:base, "You have already endorsed #{endorsee.name} for #{topic.name}")
    end
    return false
  end
end
