class Api::V1::TopicContactsController < ApplicationController

  def index
    respond_to do |format|
      @topic = request.headers["HTTP_X_CUSTOM_HEADER_TOPIC"]
      @auth = request.headers["Authorization"]
      format.html {
        render plain: graph_html
      }
    end
  end

  def show
    data = TopicSearchService.local_subgraph_from_person_and_topic(current_user,params[:topic])
    render json: D3PresenterService::Graph.new(data, current_user).to_d3
  end

  def graph_html

    <<-BASE_TEMPLATE
<!DOCTYPE HTML>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" href="/css/bootstrap.min.css">
        <link rel="stylesheet" href="/css/fontawesome.min.css">
        <link rel="stylesheet" href="/css/neo4jd3.min.css?v=0.0.1">
        <style>
            body,
            html,
            .neo4jd3 {
                height: 100%;
                overflow: hidden;
            }
        </style>
         <script src="/js/d3.min.js"></script>
        <script src="/js/infobar.js"></script>
        <!--script src="/js/neo4jd3.js"></script-->
        <script src="/js/neotest.js"></script>
        <script src="/js/nativescript-webview-interface.js"></script> 
    </head>
    <body>
        <div id="neo4jd3"></div>

        <script type="text/javascript">
          window.auth = '#{@auth}';
          window.topic = '#{@topic}';
        </script>

       <script src="/js/test.js"></script>


    </body>
</html>
    BASE_TEMPLATE
  end

end




