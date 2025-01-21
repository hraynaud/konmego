class Identity 
  include KonmegoNeo4jNode
  include ActiveModel::SecurePassword

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

  def name
    "#{first_name} #{last_name}"
  end
 
  private


  def is_oauth?
    #handle.present? && uid.present?
    false
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
