class UsersController < ApplicationController
  before_action :load_admin, only: :show
  before_action :logged_in_admin, only: [:index, :edit, :update, :destroy]
  before_action :correct_admin, only: %i(edit update)
  before_action :admin_admin, only: :destroy

  def index
    @admins = Admin.paginate(page: params[:page])
  end

  def show
    @admin = Admin.find_by(id: params[:id])
    @register = Register.new
    @ids = current_admin.course_ids

    unless @admin
      flash[:danger] = t(:user_not_found)
      redirect_to home_path
    end
  end

  def new
     @admin = Admin.new
  end

  def create
    @admin = Admin.new admin_params
    if @admin.save
      @admin.send_activation_email
      flash[:info] = t(:check)
      redirect_to home_url
    else
      render :new
    end
  end

  def update
    @admin = Admin.find(params[:id])
  end

  private

  def admin_params
    params.require(:admin).permit :name, :email, :password, :password_confirmation
  end

  def correct_admin
    @admin = Admin.find_by(id: params[:id])
    return if current_admin?(@admin)
    flash[:danger] = t("not_authorized")
    redirect_to(home_url)
  end

  def admin_admin
    redirect_to(root_url) unless current_admin.admin?
  end
end
