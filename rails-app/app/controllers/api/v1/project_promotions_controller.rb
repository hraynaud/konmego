module Api
  module V1
    class ProjectPromotionsController < ApplicationController
      before_action :load_project

      def create
        if @project && ProjectPromotionService.promote(current_user, @project)
          render json: { message: 'Project promoted successfully.' }, status: :created
        else
          render json: { errors: ['Unable to promote project.'] }, status: :unprocessable_entity
        end
      end

      def destroy
        if @project && ProjectPromotionService.demote(current_user, @project)
          render json: { message: 'Project demoted successfully.' }, status: :ok
        else
          render json: { errors: ['Unable to demote project.'] }, status: :unprocessable_entity
        end
      end

      def load_project
        @project = ProjectService.find_by_id(params[:project_id])
      end
    end
  end
end
