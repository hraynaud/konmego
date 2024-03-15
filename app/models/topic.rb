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

  before_save :generate_like_terms

  private

  def generate_like_terms
    completion = OllamaService.completion(topic_prompt)

    resp = completion[0]['response']
    data = JSON.parse(resp)

    terms = data['terms'].join(',')
    Rails.logger.debug "like terms: #{like_terms}"
    self.like_terms = "#{name},#{terms}"
  end

  def topic_prompt
    %(
    Given the topic '#{name}' generate 20 synonyms or related terms in the same category or knowledge domain
    Your response will be processed electronically so it must only include JSON.

    Here are your instructions:
    Output the data only in this exact JSON format:  {"terms":["term 1 ", "term 2", "term 3",...]}
    Do not include any helpful commentary or follow up questions in the response output.

    )
  end
end
