class Api::V1::PeopleController < ApplicationController


  def create

  end

  def show
    p = Person.find(params[:id]).try(:first)
    options = {}
    # options[:include] = [:endorsers, :endorsees]
    # options[:params] ={ref_user: p}
    render json: PersonSerializer.new(p, options).serializable_hash.to_json

  end

  def edit

  end

  def update

  end

  private


  def person_params
    params.permit(
      :id,
    )
  end

end
