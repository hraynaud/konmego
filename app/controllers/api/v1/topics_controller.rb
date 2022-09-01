class Api::V1::TopicsController < ApplicationController

    def index
        render json:  TopicSerializer.new(Topic.all).serializable_hash.to_json
    end
end