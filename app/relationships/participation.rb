class Participation
  include ActiveGraph::Relationship

  from_class :Person
  to_class   :Project
  type 'ACTS'

  enum action: [:comment, :ask_question, :answer_question, :make_referral, :remove_obstacle]
  property :notes

  validates_presence_of :action


end
