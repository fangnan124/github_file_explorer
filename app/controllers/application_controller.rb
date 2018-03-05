class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from Octokit::AbuseDetected do |exception|
    flash[:notice] = "Please wait a few minutes before you try again."
    render 'files_explorer/index'
  end
end
