class Api::V1::ProjectSearchController < ApplicationController

  def index
    render json: projects_and_topics
  end

  private

  def projects_and_topics
      projects.merge(friends_and_topics)
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
      friends: PersonSerializer.new(current_user.contacts,{fields:{ person: [:name,:id, :avatarUrl] } }),
      topics: TopicSerializer.new(Topic.all)
    }
  end


  def filter_params
    params.permit(:topic, :friend ) 
  end

end
