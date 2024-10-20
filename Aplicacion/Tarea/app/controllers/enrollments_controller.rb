class EnrollmentsController < ApplicationController
    before_action :set_course
    before_action :set_enrollment, only: %i[show edit update destroy]
  
    # List enrollments for a specific course
    def index
      @enrollments = @course.enrollments
    end
  
    # Show a specific enrollment
    def show
    end
  
    # New enrollment form
    def new
      @enrollment = @course.enrollments.build
    end
  
    # Create a new enrollment
    def create
      @enrollment = @course.enrollments.build(enrollment_params)
      if @enrollment.save
        redirect_to course_enrollments_path(@course), notice: 'Enrollment was successfully created.'
      else
        render :new
      end
    end
  
    # Edit enrollment form
    def edit
    end
  
    # Update an enrollment
    def update
      if @enrollment.update(enrollment_params)
        redirect_to course_enrollments_path(@course), notice: 'Enrollment was successfully updated.'
      else
        render :edit
      end
    end
  
    # Delete an enrollment
    def destroy
      @enrollment.destroy
      redirect_to course_enrollments_path(@course), notice: 'Enrollment was successfully deleted.'
    end
  
    private
  
    def set_course
      @course = Course.find(params[:course_id])
    end
  
    def set_enrollment
      @enrollment = @course.enrollments.find(params[:id])
    end
  
    def enrollment_params
      params.require(:enrollment).permit(:user_id, :course_id, :progress_percentage, :completed)
    end
  end
  