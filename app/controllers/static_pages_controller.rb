class StaticPagesController < ApplicationController
  def home
    @course = current_user.courses.build if logged_in?
  end

  def help; end
end
