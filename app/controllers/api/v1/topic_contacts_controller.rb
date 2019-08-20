class Api::V1::TopicContactsController < ApplicationController

  before_action :authenticate_request

  def index
  end


  def show
    contacts = TopicSearchService.find_contacts_connected_to_topic_for(current_user,params[:id])
    render json: contacts.as_json 
  end

end

