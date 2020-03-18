class Person

  include KonmegoNeo4jNode
  include ActiveModel::SecurePassword

  validates :identity, presence: true
  validates  :first_name, :last_name, presence: true, on: :update

  has_one :out, :identity, type: :IDENTITY
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
  property :bio, type: String
  property :profile_image_url, type: String
  property :avatar_url, type: String
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

end
