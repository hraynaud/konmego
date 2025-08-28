class Registration
  include KonmegoNeo4jNode

  has_one :out, :identity, model_class: :Person, type: :CREATED

  property :status, type: String
  property :reg_code, type: String
  property :reg_code_expiration, type: Integer
  property :topic_id, type: String

  property :first_name, type: String
  property :last_name, type: String
  property :email, type: String
  property :password, type: String
  property :password_digest, type: String
  scope :by_email, ->(login) { where(email: login) }

  # validates :first_name, presence: true
  # validates :last_name, presence: true
  validates :email, uniqueness: true
  validates :email, presence: true, unless: :is_oauth?
  validate :email_format
  # validates :password, :length => { :minimum => 8 }, allow_nil: true,  on: :create, unless: :is_oauth?

  # validate :has_valid_identity

  private
  def has_valid_identity
    if identity
      errors.add(
        :identity, identity.errors.full_messages.to_sentence
      ) unless identity.valid?
    end
  end
end
