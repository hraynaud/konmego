class Api::V1::ContactsController < ApplicationController

  def index 
    render json: PersonSerializer.new(contacts)
  end

  def show
    contacts.find(params[:id])
  end

  private

  def contacts
    current_user.contacts
  end
end
