require 'ostruct'

class Person
  include KonmegoNeo4jNode
  include ActiveModel::SecurePassword

  has_secure_password

  has_one :in, :inviter, model_class: :Person, type: :INVITED
  has_many :out, :invitees, model_class: :Person, type: :INVITED
  has_many :both, :contacts, model_class: :Person, type: :KNOWS, unique: true
  has_many :out, :followings, model_class: :Person, type: :FOLLOWINGS, unique: true
  has_many :in, :followers, model_class: :Person, type: :FOLLOWINGS
  has_many :out, :projects, origin: :owner
  has_many :out, :participations, model_class: :Project, type: :PARTICIPATES_IN
  has_many :in, :posts, origin: :author
  has_many :in, :comments, origin: :author
  has_many :in, :incoming_endorsements, model_class: :Endorsement, type: :ENDORSEMENT_TARGET
  has_many :in, :outgoing_endorsements, model_class: :Endorsement, type: :ENDORSEMENT_SOURCE

  # has_many :in, :endorsers, rel_class: :Endorse
  # has_many :out, :endorsees, rel_class: :Endorse
  # has_many :both, :endorsements, rel_class: :Endorse

  property :first_name, type: String
  property :last_name, type: String
  property :email, type: String
  property :password_digest, type: String
  property :bio, type: String
  property :profile_image_url, type: String
  property :avatar_url, type: String
  property :is_member, type: Boolean, default: false
  property :name, type: String
  property :pursuits, type: Hash, default: {}
  property :status, type: String
  property :reg_code, type: String
  property :reg_code_expiration, type: Integer

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: true
  validates :email, presence: true, unless: :is_oauth?
  validate :email_format
  validates :password, length: { minimum: 8 }, allow_nil: true, on: :create, unless: :is_oauth?

  scope :by_email, ->(login) { where(email: login) }

  DEFAULT_RELATIONSHIP_DEPTH = 3
  class << self
    delegate :by_email, to: :Identity

    def by_login(email)
      by_email(email).person.first
    end
  end

  def extract
    OpenStruct.new(first_name:, last_name:,
                   avatar_url:, profile_image_url:, name: "#{first_name} #{last_name}", id:)
  end

  def endorsers
    incoming_endorsements.map(&:endorser)
  end

  def endorsees
    outgoing_endorsements.map(&:endorsee)
  end

  def accepted_endorsees
    outgoing_endorsements.each.select { |r| r.status == :accepted }
  end

  def pending_endorsees
    outgoing_endorsements.each.select { |r| r.status == :pending }
  end

  def name
    "#{first_name} #{last_name}"
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def login
    email
  end

  def friends
    contacts_by_depth 1
  end

  def contacts_by_depth(depth)
    contacts(:contacts, :r, rel_length: 0..depth).distinct
  end

  def endorses?(person)
    endorsees.include? person
  end

  def endorsed_by?(person)
    endorsers.include? person
  end

  def endorses_topic?(topic)
    outgoing_endorsements.select(&:topic).include? topic
  end

  def has_endorsement_for_topic?(topic) # rubocop:disable Naming/PredicateName
    oncoming_endorsements.select(&:topic).include? topic
  end

  def friends_with?(person)
    contacts.include? person
  end

  def follows?(person)
    followings.include? person
  end

  def followed_by?(person)
    followers.include? person
  end

  private

  def is_oauth?
    # handle.present? && uid.present?
    false
  end

  def set_name
    return if identity.nil?

    self.name = "#{identity.first_name} #{identity.last_name.slice(0)}"
  end

  def using_pwd?
    password.present? && email.present?
  end

  def email_format
    return unless email && !is_valid_email?

    errors.add(:email, 'is invalid')
  end

  def is_valid_email?
    !!(email =~ URI::MailTo::EMAIL_REGEXP)
  end
end
