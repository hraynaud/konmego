module Api
  module V1
    class ProjectsController < ApplicationController
      def index
        render json: ProjectSerializer.new(current_user.projects)
      end

      def create
        project = ProjectService.create(current_user, project_params)
        render json: ProjectSerializer.new(project)
      end

      def show
        project = ProjectService.find_by_id(params[:id])
        render json: ProjectSerializer.new(project)
      end

      def update
        project = ProjectService.update(current_user, params[:id], project_params)

        if project&.persisted?
          render json: ProjectSerializer.new(project)
        else
          render json: { errors: project ? project.errors.full_messages : ['Project not found'] },
                 status: :unprocessable_entity
        end
      end

      def project_params
        params.require(:project).permit(
          :name, :description, :start_date,
          :deadline, :topic, { progress: [], tasks: [{}] }
        )
      end
    end
  end
end
