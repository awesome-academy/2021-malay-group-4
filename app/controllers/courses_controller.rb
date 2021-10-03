class CoursesController < ApplicationController
  def index
  end

  def new
    if @courses.save
      flash[:success] = t(:success_reg)
      redirect_to @courses
    else
      render :new
    end
  end
end
