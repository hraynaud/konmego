class Api::V1::TopicContactsController < ApplicationController

  skip_before_action :authenticate_request

  def index
    respond_to do |format|
      @topic = request.headers["HTTP_X_CUSTOM_HEADER_TOPIC"]
      format.html { render plain: graph_html}
    end
  end

  def show
    data = TopicSearchService.local_subgraph_from_person_and_topic(current_user,params[:topic])
    graph = D3PresenterService::Graph.new(data).to_d3
    render json: graph
  end

  def current_user
    Person.find_by(email: "foo6@example.com")
  end

  def graph_html

    <<-BASE_TEMPLATE
    <!DOCTYPE html>
    <html>
    <head>
    <meta charset="utf-8">

    <script src="/js/d3.min.js"></script>

    </head>
    <body style="background-color:lightblue">
    <canvas width="360" height="225" style="border: 1px solid red"></canvas>

    <script src="/js/graph.js"></script>

    <script>
    D3Simulation.run("/api/v1/topic_contacts/#{@topic}")
    </script>

    </body>

    </html>
    BASE_TEMPLATE
  end
end

