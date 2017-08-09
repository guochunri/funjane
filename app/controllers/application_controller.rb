class ApplicationController < ActionController::Base

  def admin_required
    if !current_user.admin?
      redirect_to "/", alert: t('warning-not-admin')
    end
  end

end
