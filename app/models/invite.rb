class Invite

  include KonmegoNeo4jNode

  property :first_name, type: String
  property :last_name, type: String
  property :topic_name, type: String
  property :email, type: String
  property :status, type: String

  has_one :out, :sender, type: :SENDER, model_class: :Person
  has_one :in, :receiver, type: :RECEIVER, model_class: :Person
  has_one :out,:topic, type: :TOPIC, model_class: :Topic
  

  validates :email, :first_name, :last_name, presence: true, if: -> {receiver.nil?}
  validates :topic_name, presence: true, if: -> {topic.nil?}
  # validates :last_name, presence: true
  # validates :email, presence: true, uniqueness: true

  validate :email_format #TODO extract duplicate email format validation to module

  def has_topic?
    ! (topic.nil? || topic_name.nil?)
  end


  def email_format
    if email && !is_valid_email?
      errors.add( :email, "is invalid")
    end
  end

  def is_valid_email?
    !!(email =~ URI::MailTo::EMAIL_REGEXP)
  end
  
end
