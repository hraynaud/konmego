class Post < Activity
  has_many :in, :comments, origin: :post
  has_one :out, :author, type: :author, model_class: :Person
  property :content, type: String
end

