class SubsController < ApplicationController

  def new
    @sub = Sub.new()
    render :new
  end

  def index
    @subs = Sub.all
    render :index
  end

  def create

    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id

    if @sub.save
      flash.notice = "You have created #{@sub.title}."
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update(sub_params)
      flash.notice = "You have edited #{@sub.title}."
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end

  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end


end