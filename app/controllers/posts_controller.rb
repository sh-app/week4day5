class PostsController < ApplicationController

  def index
    redirect_to subs_url
  end

  def new
    @post = Post.new()
    render :new
  end

  def destroy
    @post = Post.find(params[:id])
    flash.notice = "post deleted"
    @post.destroy
    redirect_to subs_url
  end

  def create

    @post = Post.new(post_params)
    @post.author_id = current_user.id

    if @post.save
      flash.notice = "You have created #{@post.title}."
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash.notice = "You have edited #{@post.title}."
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end

  end

  private
  def post_params
    params.require(:post).permit(:title, :content, :url, sub_ids: [])
  end


end
