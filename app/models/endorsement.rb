require 'ostruct'
class Endorsement
  include KonmegoNeo4jNode

  has_one :out, :endorser, type: :ENDORSEMENT_SOURCE, model_class: :Person
  has_one :out, :endorsee, type: :ENDORSEMENT_TARGET, model_class: :Person
  has_one :out, :topic, type: :TOPIC

  property :description
  enum status: { pending: 'pending', accepted: 'accepted', declined: 'declined' }, _default: :pending

  before_validation :save_endorsee
  validates :endorsee, :endorser, :topic, presence: true
  validate :has_valid_topic
  validate :has_valid_endorsee
  validate :is_unique_across_endorser_endorsee_and_topic, on: :create, if: :all_valid?

  scope :accepted, -> { where(status: :accepted) }
  scope :accepted_or_pending, -> { where(status: %i[pending accepted]) }

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

  def direction_from_person(p)
    endorser == p ? 'outgoing' : 'incoming'
  end

  def extract
    OpenStruct.new(endorser:, endorsee:, description:)
  end

  private

  def is_unique_across_endorser_endorsee_and_topic
    return unless Endorsement.where(endorser:, endorsee:, topic:).any?

    errors.add(:base, "You have already endorsed #{endorsee.name} for #{topic_name}")
    false
  end

  def has_valid_topic
    return unless topic

    return if topic.valid?

    errors.add(
      :topic, topic.errors.full_messages.to_sentence
    )
  end

  def has_valid_endorsee
    return unless endorsee

    return if endorsee.valid?

    errors.add(
      :endorsee, endorsee.errors.full_messages.to_sentence
    )
  end

  def all_valid?
    endorser && endorser.valid? && endorsee && endorsee.valid? && topic && topic.valid?
  end

  def save_endorsee
    endorsee.save if endorsee && endorsee.new_record?
  end
end
