# require "#{Rails.root}/lib/neo4jrb/array_converter.rb"

class Topic
  include KonmegoNeo4jNode

  property :name, type: String
  property :default_image_file, type: String
  property :icon, type: String
  property :like_terms

  validates :name, presence: true
  has_many :in, :endorsements, origin: :topic
  has_many :in, :projects, origin: :CONCERNS
end
