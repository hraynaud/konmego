class Person

  include Neo4j::ActiveNode
  include ActiveModel::SecurePassword

  has_secure_password

  validates :email, uniqueness: true
  validates :email, presence: true, unless: :is_oauth?
  validates :password, :length => { :minimum => 5 }, allow_nil: true,  on: :create, unless: :is_oauth?

  has_many :out, :contacts, type: :KNOWS, model_class: :Person
  has_many :in, :incoming_endorsements, model_class: :Endorsement, type: :ENDORSEMENT_TARGET
  has_many :in, :outgoing_endorsements, model_class: :Endorsement, type: :ENDORSEMENT_SOURCE

  property :first_name, type: String
  property :last_name, type: String
  property :email, type: String
  property :password_digest, type: String

  private

  def is_oauth?
    #handle.present? && uid.present?
    false
  end

  def using_pwd?
    password.present? && email.present?
  end
end
