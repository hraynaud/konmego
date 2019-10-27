module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern

  included do
    rescue_from Neo4j::ActiveNode::Labels::RecordNotFound do |e|
      respond_with_error(e.message,  :not_found)
    end

    rescue_from Neo4j::ActiveNode::Persistence::RecordInvalidError do |e|
      respond_with_error(e.message, :unprocessable_entity, e.record.errors)
    end
  end
end
