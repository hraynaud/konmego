class Api::V1::TopicContactsController < ApplicationController
  #skip_before_action :authenticate_request
  
  def index
    respond_to do |format|
       @topic = request.headers["HTTP_X_CUSTOM_HEADER_TOPIC"]
       @auth = request.headers["Authorization"]
      format.html {
        render plain: graph_html.html_safe
      }
    end
  end

  def show
    data = TopicSearchService.local_subgraph_from_person_and_topic(current_user,params[:topic])
    graph = D3PresenterService::Graph.new(data, current_user).to_d3
    render json: graph
  end

  #def current_user
    #@user ||=Person.where(email: 'foo2@example.com').first
  #end


  def graph_html

    <<-BASE_TEMPLATE
<!DOCTYPE HTML>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" href="/css/bootstrap.min.css">
        <link rel="stylesheet" href="/css/font-awesome.min.css">
        <link rel="stylesheet" href="/css/neo4jd3.min.css?v=0.0.1">

        <script src="/js/d3.min.js"></script>
       <script src="/js/infobar.js"></script>
        <script src="/js/neo4jd3.js"></script>
        <style>
            body,
            html,
            .neo4jd3 {
                height: 100%;
                overflow: hidden;
            }
        </style>
    </head>
    <body>
        <div id="neo4jd3"></div>

        <script type="text/javascript">
            function init() {
                var neo4jd3 = new Neo4jD3('#neo4jd3', {
                    minCollision: 60,
                    neo4jDataUrl: '/api/v1/topic_contacts/#{@topic}',
                    neo4jJsonAuthHeader: '#{@auth}',
                    nodeRadius: 25,
                });
            }

            window.onload = init;
        </script>

    </body>
</html>
    BASE_TEMPLATE
  end
end

