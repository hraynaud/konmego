class Endorsement

  include Neo4j::ActiveNode

  has_one :out, :endorser, type: :ENDORSEMENT_SOURCE, model_class: :Person
  has_one :out, :endorsee, type: :ENDORSEMENT_TARGET, model_class: :Person
  has_one :out, :topic, type: :ENDORSE_TOPIC

  property :description
  enum status: [:pending, :accepted, :declined], _default: :pending

  before_create :add_description
  after_create :create_user_relationship

  validate :validate_uniqueness_of_endorsement, on: :create

  def accept
     self.status = :accepted
  end

  def decline
     self.status = :declined
  end

  def create_user_relationship
    RelationshipManager.create_friendship_if_none_exists self
  end

  private

  def add_description
    self.description = "#{endorser.name} Endorses #{endorsee.name} for #{topic.name}"
  end

  def validate_uniqueness_of_endorsement
    if Endorsement.where(endorser: endorser, endorsee: endorsee, topic: topic).any?
      errors.add(:base, "You have already endorsed #{endorsee.name} for #{topic.name}")
    end
    return false
  end
end
