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
    ProjectSearchService.search(current_user, topic: search_topic, friend: search_friend)
  end

  def friends_and_topics
    {
      friends: PersonSerializer.new(friends),
      topics: TopicSerializer.new(unique_project_topic_list)
    }
  end

  def friends
    current_user.contacts
  end

  def unique_project_topic_list
    search_results.map(&:topic).uniq
  end

  def no_search_params_provided?
    search_friend.blank? && search_topic.blank?
  end

  def search_topic
    filter_params[:topic]
  end

  def search_friend
    filter_params[:friend]
  end

  def filter_params
    params.permit(:topic, :friend ) 
  end

end
