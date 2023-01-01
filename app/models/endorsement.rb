require 'ostruct'
class Endorsement

  include KonmegoNeo4jNode

  has_one :out, :endorser, type: :ENDORSEMENT_SOURCE, model_class: :Person
  has_one :out, :endorsee, type: :ENDORSEMENT_TARGET, model_class: :Person
  has_one :out, :topic, type: :ENDORSE_TOPIC

  property :description
  enum status: [:pending, :accepted, :declined], _default: :pending

  before_create :add_description

  before_validation :save_endorsee
  validates :endorsee, :endorser, :topic, presence: true
  validate :has_valid_topic
  validate :has_valid_endorsee
  validate :is_unique_across_endorser_endorsee_and_topic, on: :create, if: :all_valid?

  scope :accepted,  ->{where(status: :accepted)}
  scope :accepted_or_pending,  ->{where(status: [:pending,:accepted])}

  def topic_name 
    topic.name
  end

  def topic_image
    topic.default_image_file
  end 

  def endorser_id
    endorser.neo_id
  end

  def endorsee_id
    endorsee.neo_id
  end

  def endorser_avatar_url
    endorser.avatar_url
  end

  def endorsee_avatar_url
    endorsee.avatar_url
  end

  def direction_from_person p
    endorser == p ? "outgoing" : "incoming" 
  end

  def extract
    OpenStruct.new(endorser: endorsement.endorser, endorsee: endorsement.endorsee, description:endorsement.description)
  end

  private

  def add_description
    self.description = "#{endorser.name} endorses #{endorsee.name} for #{topic_name}"
  end

  def is_unique_across_endorser_endorsee_and_topic
    if Endorsement.where(endorser: endorser, endorsee: endorsee, topic: topic).any?
      errors.add(:base, "You have already endorsed #{endorsee.name} for #{topic_name}")
      return false
    end
  end

  def has_valid_topic
    if topic
      errors.add(
        :topic, topic.errors.full_messages.to_sentence
      ) unless topic.valid? 
    end
  end

  def has_valid_endorsee
    if endorsee
      errors.add(
        :endorsee, endorsee.errors.full_messages.to_sentence
      ) unless endorsee.valid?
    end
  end

  def all_valid?
    endorser && endorser.valid? && endorsee && endorsee.valid? && topic && topic.valid?
  end

  def save_endorsee
    endorsee.save if endorsee && endorsee.new_record?
  end


end
