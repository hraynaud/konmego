
require 'ostruct'

class Person

  include KonmegoNeo4jNode

  validates :identity, presence: true, if: :is_member

  has_one :out, :identity, type: :IDENTITY
  has_many :both, :contacts, model_class: :Person, type: :KNOWS, unique: true
  has_many :out, :followings, model_class: :Person, type: :FOLLOWINGS, unique: true
  has_many :in, :followers, model_class: :Person, type: :FOLLOWINGS
  has_many :in, :incoming_endorsements, model_class: :Endorsement, type: :ENDORSEMENT_TARGET
  has_many :in, :outgoing_endorsements, model_class: :Endorsement, type: :ENDORSEMENT_SOURCE
  has_many :both, :endorsements, model_class: :Endorsement, type: false
  has_many :out, :projects, origin: :owner
  has_many :out, :participations, model_class: :Project, type: :PARTICIPATES_IN
  has_many :in, :posts, origin: :author
  has_many :in, :comments, origin: :author

  property :bio, type: String
  property :profile_image_url, type: String
  property :avatar_url, type: String
  property :is_member, type: Boolean, default: false

  #TODO Add profile model


  DEFAULT_RELATIONSHIP_DEPTH = 3

  class << self
    delegate :by_email, to: :Identity
    
    def by_login email
      by_email(email).person.first
    end
  end 

  def extract
    OpenStruct.new(first_name: first_name, last_name: last_name,
                   avatar_url: avatar_url, profile_image_url: profile_image_url, name: "#{first_name} #{last_name}", id: id)
  end

  def first_name
    identity.first_name
  end

  def last_name
    identity.last_name
  end

  def name
    "#{first_name} #{last_name}"
  end

  def login
    email
  end

  def email
    identity.email
  end

  def friends 
    contacts_by_depth 1
  end

  def endorsees
    outgoing_endorsements.map(&:endorsee)
  end

 


  def endorsers
    incoming_endorsements.map(&:endorser)
  end

  def contacts_by_depth depth 
    contacts(:contacts, :r, rel_length: 0..depth).distinct
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


  private

end
