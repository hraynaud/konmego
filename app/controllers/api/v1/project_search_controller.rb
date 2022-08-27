class Api::V1::ProjectSearchController < ApplicationController

  def index
    render json: projects_and_topics
  end

  private

  def projects_and_topics
    if no_search_params_provided?
      projects.merge(friends_and_topics)
    else
      projects
    end
  end

  def projects
    {
      projects: ProjectSerializer.new(search_results)
    }
  end

  def search_results
    ProjectSearchService.search(current_user, topic: filter_params[:topic], friend: filter_params[:friend])
  end

  def friends_and_topics
    {
      friends: PersonSerializer.new(current_user.contacts),
      topics: TopicSerializer.new(unique_project_topic_list)
    }
  end

  def unique_project_topic_list
    search_results.map(&:topic).uniq
  end

  def no_search_params_provided?
    filter_params[:friend].blank? && filter_params[:topic].blank?
  end

  def filter_params
    params.permit(:topic, :friend ) 
  end

end
