class CoursesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @course = current_user.courses.build course_params
    if @course.save
      flash[:success] = t(:course_created)
      redirect_to root_url
    else
      render "static_pages/home"
    end
  end

  private

  def course_params
    params.require(:course).permit :content, :image
  end
end
