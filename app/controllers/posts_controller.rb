class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like]
  def index
    if params[:set_locale]
      redirect_to posts_url(locale: params[:set_locale])
    else
      if params[:date]
        temp = params[:date].scan(/[0-9]+/)
        @today = Time.new(temp[0], temp[1], temp[2])
        @posts = Post.where(created_at: @today.midnight..@today.midnight + 1.day)
        @posts = @posts.sort_by{|post| post.liked.count }.reverse
      else
        @posts = Post.where(created_at: Time.now.midnight..Time.now.midnight + 1.day)
        @posts = @posts.sort_by{|post| post.liked.count }.reverse
      end
    end
  end

  def history
    @groups = Post.all.group_by{|c| c.created_at.to_date }
  end

  def like
    authorize @post, :create?
    if @post.liked.include?(current_user)
      flash[:notice] = I18n.t('.already_liked_post')
      redirect_to post_path(@post)
    else
      @post.liked << current_user
      flash[:notice] = I18n.t('.liked_post')
      redirect_to post_path(@post)
    end
  end

  def new
    @post = Post.new
    authorize @post, :create?
  end

  def create
    @post = Post.new(post_params)
    authorize @post, :create?
    @post.author = current_user
    if @post.save
      flash[:notice] = I18n.t('.post_created')
      redirect_to post_path(@post)
    else
      flash.now[:alert] = I18n.t('.post_not_created')
      render "new"
    end
  end

  def show
    @comment = Comment.new
  end

  def edit
    authorize @post, :update?
  end

  def update
    authorize @post, :update?
    if @post.update(post_params)
      flash[:notice] = I18n.t('.post_updated')
      redirect_to post_path(@post)
    else
      flash.now[:alert] = I18n.t('.post_not_updated')
      render "edit"
    end
  end

  def destroy
    authorize @post, :destroy?
    @post.destroy

    flash[:notice] = I18n.t('.post_deleted')
    redirect_to posts_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
