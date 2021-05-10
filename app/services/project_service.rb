require 'securerandom'

class ProjectService

  class << self

    def create owner, params
      Project.new(params).tap do |project|
        project.owner = owner
        project.save!
      end
    end

  end

end
