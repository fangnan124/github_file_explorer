class FilesExplorerController < ApplicationController

  def index
    service_params = files_explorer_service_params.tap do |p|
      p[:repo_name] ||= 'rails/rails'
      p[:keyword] ||= 'active'
      p[:page] ||= 1
      p[:per_page] ||= 5
    end

    @service = FilesExplorerService.new service_params

    unless @service.repository_exist?
      flash.now[:notice] = "Repository does not exist."
      return
    end

    unless @service.keyword.present?
      flash.now[:notice] = "Keyword can not be blank."
      return
    end

    @result = @service.search
  end

  private

  def files_explorer_service_params
    params.permit(
        :repo_name,
        :keyword,
        :page,
        :per_page
    )
  end

end