class Api::V1::PostsController < ApplicationController

  def create 

    project = current_user.projects.where(id: params[:project_id]).first
    post = Post.create({content: params[:content]})
    project.posts << post
    render json: post
  end


  def edit
  end
  
  def update
  end
  private

  def relationship_group
    current_user.send(params[:relationship_group].to_sym)
  end
end
