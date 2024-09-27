class PagesController < ApplicationController
  def home
    @courses = Course.order(created_at: :desc).limit(3)
  end
end
