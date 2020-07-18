class ProjectActivityService
  class << self
    def particpate person, action_type
      p = Participation.new(from_node: person, to_node: self)
    end

    def build_action participation, action_type
      case action_type 
      when Participation.action_type[:ask_question]

      when Participation.action_type[:answer_question]

      when Participation.action_type[:make_referral]

      when Participation.action_type[:remove_obstacle]

      else Participation.action_type[:comment]
      end
    end

    def is_of type
      Participation.action_type[type]
    end
  end
end
