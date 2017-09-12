class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true
  before_action :configure_permitted_parameters,
                if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to root_url, alert: exception.message }
      format.js { head :unauthorized }
    end
  end

  add_breadcrumb I18n.t('homes.index.title'), :root_path,
                 if: proc { params[:controller] != 'homes' }

  protected

  def configure_permitted_parameters
    attrs = %i[username email password password_confirmation]
    update_attrs = attrs + %i[avatar avatar_cache remove_avatar current_password]
    update_attrs.push(:role) if current_user&.master_role?

    devise_parameter_sanitizer.permit :sign_up, keys: attrs
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
  end
end
