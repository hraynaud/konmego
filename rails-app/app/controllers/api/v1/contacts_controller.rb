class Api::V1::ContactsController < ApplicationController
  def index
    render json: PersonSerializer.new(contacts, { params: { current_user: } })
  end

  def create
    InviteService.create current_user, invite_params
  end

  def show
    contacts.find(params[:id])
  end

  private

  def contacts
    current_user.contacts
  end
end
