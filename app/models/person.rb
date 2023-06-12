
require 'ostruct'

class Person

  include KonmegoNeo4jNode
  include ActiveModel::SecurePassword

  # validates :identity, presence: true, if: :is_member

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: true
  validates :email, presence: true, unless: :is_oauth?
  validate :email_format
  validates :password, :length => { :minimum => 8 }, allow_nil: true,  on: :create, unless: :is_oauth?

  has_one :in, :person, type: nil

  property :first_name, type: String
  property :last_name, type: String
  property :email, type: String
  property :password_digest, type: String
  scope :by_email, ->(login){where(email: login)}


  has_one :out, :identity, type: :IDENTITY
  has_many :both, :contacts, model_class: :Person, type: :KNOWS, unique: true
  has_many :out, :followings, model_class: :Person, type: :FOLLOWINGS, unique: true
  has_many :in, :followers, model_class: :Person, type: :FOLLOWINGS


  has_many :in, :endorsers, rel_class: :Endorse
  has_many :out, :endorsees, rel_class: :Endorse

  has_many :out, :projects, origin: :owner
  has_many :out, :participations, model_class: :Project, type: :PARTICIPATES_IN
  has_many :in, :posts, origin: :author
  has_many :in, :comments, origin: :author

  property :bio, type: String
  property :profile_image_url, type: String
  property :avatar_url, type: String
  property :is_member, type: Boolean, default: false
  property :name, type: String

  # before_create :set_name

  #TODO Add profile model


  DEFAULT_RELATIONSHIP_DEPTH = 3

  class << self
    delegate :by_email, to: :Identity
    
    def by_login email
      by_email(email).person.first
    end

    def from_identity id
      identity(:i).where(id: id).person
    end

  end 

  def extract
    OpenStruct.new(first_name: first_name, last_name: last_name,
                   avatar_url: avatar_url, profile_image_url: profile_image_url, name: "#{first_name} #{last_name}", id: id)
  end

  # def first_name
  #   identity.first_name
  # end

  # def last_name
  #   identity.last_name
  # end

  # def name
  #   "#{first_name} #{last_name}"
  # end

  def full_name
    "#{first_name} #{last_name}"
  end 

  def login
    email
  end

  # def identity_id
  #   identity.id
  # end


  # def email
  #   identity.email
  # end

  def friends 
    contacts_by_depth 1
  end

  def contacts_by_depth depth 
    contacts(:contacts, :r, rel_length: 0..depth).distinct
  end

  def endorses? person
    outgoing_endorsements.endorsee.include? person
  end

  def endorsed_by? person
    endorsers.include? person
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

  private

  def is_oauth?
    #handle.present? && uid.present?
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
    if email && !is_valid_email?
      errors.add( :email, "is invalid")
    end
  end

  def is_valid_email?
    !!(email =~ URI::MailTo::EMAIL_REGEXP)
  end
end
