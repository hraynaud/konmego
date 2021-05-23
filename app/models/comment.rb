class Comment
  include KonmegoNeo4jNode

  validates :text, presence: true

  has_one :out, :post, type: nil
  has_one :out, :author, type: :author, model_class: :Person
end
