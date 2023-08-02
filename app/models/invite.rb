class Invite

  include KonmegoNeo4jNode

  property :first_name, type: String
  property :last_name, type: String
  property :email, type: String
  # enum status: {pending: "pending", accepted: "accepted", declined: "declined"}, _default: :pending
  property :expiration, type: Date
  property :status, type: String

  property :topic_id, type: String
  
  has_one :out, :sender, type: :SENDER, model_class: :Person
  has_one :in, :receiver, type: :RECEIVER, model_class: :Person

  
  validates :email, :first_name, :last_name, presence: true, if: -> {receiver.nil?}

  validates :email, uniqueness: true

  validate :email_format #TODO extract duplicate email format validation to module

 
  def email_format
    if email && !is_valid_email?
      errors.add( :email, "is invalid")
    end
  end

  def is_valid_email?
    !!(email =~ URI::MailTo::EMAIL_REGEXP)
  end
  
end
