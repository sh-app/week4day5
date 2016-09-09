class CommentsController < ApplicationController

  def new
    @comment = Comment.new()
    render :new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    @comment.post_id = params[:id]

    if @comment.save
      flash.notice = "You have created a comment."
      redirect_to post_url(@comment.post)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    render :edit
  end

  def update
    @comment = Comment.find(params[:id])

    if @Comment.update(comment_params)
      flash.notice = "You have edited your comment."
      redirect_to post_url(@comment.post)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :edit
    end

  end


  def destroy
    @comment = Comment.find(params[:id])
    flash.notice = "comment deleted"
    @comment.destroy
    redirect_to post_url(@comment.post)
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
