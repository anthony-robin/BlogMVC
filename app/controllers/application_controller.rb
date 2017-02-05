class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to root_url, alert: exception.message }
    end
  end
end
