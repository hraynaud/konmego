class Api::V1::TopicsController < ApplicationController

    def index
        render json:  TopicSerializer.new(Topic.all).serializable_hash.to_json
    end
     
    def create
        topic = TopicService.create(current_user,project_params)
        json_response(topic.to_json, :ok)
      end
end
