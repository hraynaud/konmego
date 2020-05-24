class Api::V1::ProjectSearchController < ApplicationController

  def index
    render json: projects_and_topics
  end

  private

  def friends
    current_user.contacts
  end

  def projects_and_topics
    if params[:friend].blank? && params[:topic].blank?
      found_projects.merge(friends_and_topics)
    else
      found_projects
    end
  end

  def found_projects
    {
      projects: ProjectSerializer.new(projects)
    }
  end

  def friends_and_topics
    {
      friends: PersonSerializer.new(friends),
      topics: TopicSerializer.new(projects.map(&:topic).uniq)
    }
  end

  def projects
    ProjectSearchService.search(current_user, resolved_params)
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
