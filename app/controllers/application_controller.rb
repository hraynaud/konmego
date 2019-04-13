class ApplicationController < ActionController::API

  before_action :authenticate_request, only: [:current_user]

  def preflight
    head :ok
  end

  def current_user
    render json: @current_user, only: [:handle]
  end

  def index
    render file: 'public/index.html'
  end

end
