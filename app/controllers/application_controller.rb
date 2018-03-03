class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # class Api::Github::NonExistentRepositoryError < StandardError; end
  #
  # rescue_from Api::Github::NonExistentRepositoryError do |exception|
  #   flash[:notice] = "Repository does not exist."
  # end
end
