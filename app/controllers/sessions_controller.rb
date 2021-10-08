class SessionsController < ApplicationController
  def new
  end

  def create
    @admin = Admin.find_by email: params[:session][:email].downcase
    if @admin && @admin.authenticate(params[:session][:password])
      if @admin.activated
        log_in admin
        redirect_to admin
        params[:session][:remember_me] == "1" ? remember(@admin) : forget(@admin)
        redirect_back_or @admin
      else
        message = "Account not activated. Check your email for the activation link."
        flash[:warning] = message
        redirect_to_home_url
      end
    else
      flash.now[:danger] = t(:invalid_email_password_combination)
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to home_path
  end
end
