class Api::V1::TopicContactsController < ApplicationController

  def index
  end

  def show
    data = TopicSearchService.local_subgraph_from_person_and_topic(current_user,params[:topic])
    graph = D3PresenterService::Graph.new(data).to_d3
    render json: graph
  end

end

