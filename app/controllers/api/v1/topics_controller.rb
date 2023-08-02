class Api::V1::TopicsController < ApplicationController

    def index
        render json:  TopicSerializer.new(Topic.all).serializable_hash.to_json
    end
     
    def create
        topic = TopicService.create(current_user,topic_params)
        json_response(topic.to_json, :ok)
    end



    def topic_params
        params.permit(:topic)
    end 
end
