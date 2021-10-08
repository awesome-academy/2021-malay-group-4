module SessionsHelper
  def log_in admin
    session[:user_id] = admin.id
  end

  def current_admin
    if user_id = session[:admin_id]
      @current_admin ||= Admin.find_by id: admin_id
    elsif (admin_id = cookies.signed[:admin_id])
      user = Admin.find_by id: admin_id
      if admin&.authenticated?(cookies[:remember_token])
        log_in admin
        @current_admin = admin
      end
    end
  end

  def logged_in?
    current_admin.present?
  end

  def log_out
    forget(current_admin)
    session.delete(:admin_id)
    @current_admin = nil
  end

  def remember admin
    admin.remember
    cookies.permanent.signed[:admin_id] = admin.id
    cookies.permanent[:remember_token] = admin.remember_token
  end

  def forget(admin)
   admin.forget
   cookies.delete(:admin_id)
   cookies.delete(:remember_token)
  end

  def redirect_back_or default
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  def current_admin? admin
    admin == current_admin
  end
end
