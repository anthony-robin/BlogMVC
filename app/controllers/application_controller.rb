class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to root_url, alert: exception.message }
      format.js { head :unauthorized }
    end
  end

  add_breadcrumb I18n.t('homes.index.title'), :root_path,
                 if: proc { params[:controller] != 'homes' }

  # Redirects to login page when {User user} is not
  # authenticated on a page that requires login.
  #
  def not_authenticated
    respond_to do |format|
      format.html { redirect_to new_sessions_url, alert: t('sorcery.not_authenticated') }
      format.js { head :unauthorized }
    end
  end
end
