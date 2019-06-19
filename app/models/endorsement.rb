class Endorsement

  include Neo4j::ActiveNode

  has_one :out, :endorser, type: :ENDORSEMENT_SOURCE, model_class: :Person
  has_one :out, :endorsee, type: :ENDORSEMENT_TARGET, model_class: :Person
  has_one :out, :topic, type: :ENDORSE_TOPIC

  property :description
  enum type: [:pending, :accepted, :declined], _default: :pending


end
