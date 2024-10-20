class ForumsController < ApplicationController
    before_action :set_forum, only: [:show, :edit, :update, :destroy]
    before_action :set_course, only: [:new, :create, :edit, :update]
  
    def index
      @forums = Forum.all
    end
  
    def show
    end
  
    def new
      @forum = @course.forums.new
    end
  
    def create
      @forum = @course.forums.new(forum_params)
      if @forum.save
        redirect_to course_forum_path(@course, @forum), notice: 'Forum was successfully created.'
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @forum.update(forum_params)
        redirect_to course_forum_path(@forum.course, @forum), notice: 'Forum was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @forum.destroy
      redirect_to course_path(@forum.course), notice: 'Forum was successfully deleted.'
    end
  
    private
  
    def set_forum
      @forum = Forum.find(params[:id])
    end
  
    def set_course
      @course = Course.find(params[:course_id])
    end
  
    def forum_params
      params.require(:forum).permit(:title, :course_id)
    end
  end
  