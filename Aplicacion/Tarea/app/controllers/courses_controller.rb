class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :require_instructor_role!, only: [:new, :create]
  before_action :authorize_course_owner!, only: [:edit, :update, :destroy]

  def index
    @courses = Course.all
  end
  def show
    @course = Course.find(params[:id])
  end
  
  def new
    @course = Course.new
  end

  def create
    @course = current_user.instructed_courses.build(course_params)
    if @course.save
      redirect_to @course, notice: 'Course was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  # PATCH/PUT /courses/1
  def update
    if @course.update(course_params)
      redirect_to @course, notice: 'Course was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /courses/1
  def destroy
    @course.destroy
    redirect_to courses_url, notice: 'Course was successfully deleted.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:title, :description)
    end

    def authorize_instructor!
      unless current_user.role == 'instructor'
        redirect_to courses_path, alert: 'You are not authorized to perform this action.'
      end
    end

    def authorize_course_owner!
      unless current_user == @course.instructor
        redirect_to courses_path, alert: 'You are not authorized to perform this action.'
      end
    end
end
