class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like]
  def index
    @posts = Post.all
  end

  def like
    authorize @post, :create?
    if @post.liked.include?(current_user)
      flash[:notice] = "You already liked this post."
      redirect_to post_path(@post)
    else
      @post.liked << current_user
      flash[:notice] = "You liked this post."
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
      flash[:notice] = "Post has been created."
      redirect_to post_path(@post)
    else
      flash.now[:alert] = "Post has not been created."
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
      flash[:notice] = "Post has been updated."
      redirect_to post_path(@post)
    else
      flash.now[:alert] = "Post has not been updated."
      render "edit"
    end
  end

  def destroy
    authorize @post, :destroy?
    @post.destroy

    flash[:notice] = "Post has been deleted."
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
