class Api::V1::ProjectSearchController < ApplicationController

  def index
    render json: payload
  end

  private

  def friends
    current_user.contacts
  end

  def payload
    {
      projects: ProjectSerializer.new(ProjectSearchService.search(current_user, resolved_params)),
      friends: PersonSerializer.new(friends)
    }
  end

  def resolved_params
    {topic: get_topic, friend: get_friend} 
  end

  def get_topic
    filter_params[:topic] ? Topic.find(filter_params[:topic]) : nil
  end

  def get_friend
    filter_params[:friend] ? Person.find(filter_params[:friend]) : nil
  end

  def filter_params
    params.permit(:topic, :friend ) 
  end
end
