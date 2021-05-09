require 'active_graph'
module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern

  included do
    rescue_from ::ActiveGraph::Node::Labels::RecordNotFound do |e|
      respond_with_error(e.message,  :not_found)
    end

    rescue_from ::ActiveGraph::Node::Persistence::RecordInvalidError do |e|
      respond_with_error(e.message, :unprocessable_entity, e.record.errors)
    end

    rescue_from ::RuntimeError do |e|
      respond_with_error(e.message, :unprocessable_entity, [])
    end
  end
end
