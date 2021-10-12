class CoursesController < ApplicationController
  before_action :logged_in_user

  def index
    @courses = Course.all
  end

  def show
    @course = Course.find_by(id: params[:id])
    @register = Register.new
    @ids = @course.user_ids
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      flash[:success] = "Course created!"
      redirect_to @course
    else
      flash[:danger] = "Course create failed"
      render :new
    end
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])

    if @course.status == "Started"
      @course.started_at = Time.zone.now
    end

    if @course.update(course_params)
      flash[:success] = "Course updated"
      redirect_to @course
    else
      flash[:success] = "Course update failed"
      render :edit
    end
  end

  def destroy
    @course = Course.find(params[:id])

    if @course.status == "Opening"
      @course.destroy
      flash[:success] = "Course deleted"
      redirect_to courses_path
    else
      flash[:danger] = "Course in progress/finished"
      redirect_to courses_path
    end
  end

  private

  def course_params
    params.require(:course).permit(:name, :description, :status, :total_month, :started_at)
  end
end
