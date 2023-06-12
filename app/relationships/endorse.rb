class Endorse
  include ActiveGraph::Relationship

  from_class :Person
  to_class   :Person
  type 'ENDORSES'
  creates_unique on: [:topic]

  property :topic
  enum topic_status: [:new, :existing], _default: :new
  property :description
  enum status: [:pending, :accepted, :declined], _default: :pending

  validates_presence_of :topic
  # validate :is_unique_across_endorser_endorsee_and_topic, on: :create, if: :all_valid?


  # def is_unique_across_endorser_endorsee_and_topic
  #   binding.pry
  #   if (from_node.endorsees.include? to_node) && from_node
  #     errors.add(:base, "You have already endorsed #{to_node.name} for #{topic_name}")
  #     return false
  #   end
  # end



  # def all_valid?
  #   from_node && from_node.valid? && to_node && to_node.valid? && topic.present?
  # end
end
