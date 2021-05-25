class Comment < Activity

  validates :text, presence: true

  has_one :out, :post, type: nil
  has_one :out, :author, type: :author, model_class: :Person
end
