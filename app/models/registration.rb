class Registration

  include KonmegoNeo4jNode

  has_one :out, :identity, type: :IDENTITY

  property :status, type: String
  property :reg_code, type: String
  property :reg_code_expiration, type: Integer
  property :topic_id, type: String

  validate :has_valid_identity

  delegate :email, :first_name, :last_name, :name, :authenticate, to: :identity

  private
  def has_valid_identity
    if identity
      errors.add(
        :identity, identity.errors.full_messages.to_sentence
      ) unless identity.valid? 
    end
  end
end
