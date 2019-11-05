class Person

  include KonmegoActiveNode
  include ActiveModel::SecurePassword

  has_secure_password

  validates :email, uniqueness: true
  validates :email, :first_name, :last_name, presence: true, unless: :is_oauth?
  validates :password, :length => { :minimum => 8 }, allow_nil: true,  on: :create, unless: :is_oauth?
  validate :email_format

  has_many :both, :contacts, model_class: :Person, type: :KNOWS, unique: true
  has_many :out, :followings, model_class: :Person, type: :FOLLOWINGS, unique: true
  has_many :in, :followers, model_class: :Person, type: :FOLLOWINGS
  has_many :in, :incoming_endorsements, model_class: :Endorsement, type: :ENDORSEMENT_TARGET
  has_many :in, :outgoing_endorsements, model_class: :Endorsement, type: :ENDORSEMENT_SOURCE
  has_many :out, :projects, origin: :owner

  property :first_name, type: String
  property :last_name, type: String
  property :email, type: String
  property :password_digest, type: String
  property :is_member, type: Boolean, default: false

  def name
    "#{first_name} #{last_name}"
  end

  def endorses? person
    outgoing_endorsements.endorsee.include? person
  end

  def endorsed_by? person
    incoming_endorsements.endorser.include? person
  end

  def endorses_topic? topic
    outgoing_endorsements.topic.include? topic
  end

  def has_endorsement_for_topic? topic
    incoming_endorsements.topic.include? topic
  end

  def friends_with? person
    contacts.include? person
  end

  def follows? person
    followings.include? person
  end

  def followed_by? person
    followers.include? person
  end

  def endorsees
    outgoing_endorsements.map(&:endorsee)
  end

  def endorsers
    incoming_endorsements.map(&:endorser)
  end

  private

  def email_format
    if email && !is_valid_email?
      errors.add( :email, "is invalid")
    end
  end

  def is_oauth?
    #handle.present? && uid.present?
    false
  end

  def using_pwd?
    password.present? && email.present?
  end

  def is_valid_email?
    !!(email =~ URI::MailTo::EMAIL_REGEXP)
  end
end
