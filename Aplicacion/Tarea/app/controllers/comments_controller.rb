class CommentsController < ApplicationController
    before_action :set_forum
    before_action :set_comment, only: [:edit, :update, :destroy]
  
    def new
      @comment = @forum.comments.build
    end
  
    def create
      @comment = @forum.comments.build(comment_params)
      @comment.user = current_user
      if @comment.save
        redirect_to forum_path(@forum), notice: 'Comment was successfully created.'
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @comment.update(comment_params)
        redirect_to forum_path(@forum), notice: 'Comment was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @comment.destroy
      redirect_to forum_path(@forum), notice: 'Comment was successfully deleted.'
    end
  
    private
  
    def set_forum
      @forum = Forum.find(params[:forum_id])
    end
  
    def set_comment
      @comment = @forum.comments.find(params[:id])
    end
  
    def comment_params
      params.require(:comment).permit(:content)
    end
  end
  