class HomeController < ApplicationController
  def index
    @popular_courses = Course.most_popular.includes(:category)
    @newest_courses = Course.newest.includes(:category)
    @tags = Tag.all
  end

  def search
    @courses = Course.get_courses params[:name]
  end
end
