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

  def topic_name
    topic.name
  end

  Extract = Struct.new(:endorser, :endorsee, :description, keyword_init: true) do
    def name 
      "#{first_name} #{last_name}"
    end
  end

  private

  def add_description
    self.description = "#{endorser.name} endorses someone for #{topic_name}"
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
