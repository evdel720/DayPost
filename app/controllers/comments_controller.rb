class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: [:show, :edit, :update, :destroy, :like]
  def new
    @comment = Comment.new
    authorize @comment, :create?
  end

  def create
    @comment = Comment.new(comment_params)
    authorize @comment, :create?
    @comment.post = @post
    @comment.author = current_user
    if @comment.save
      flash[:notice] = "Comment has been created."
      redirect_to post_path(@post)
    else
      flash[:alert] = "Comment has not been created."
      redirect_to post_path(@post)
    end
  end

  def like
    authorize @comment, :create?
    if @comment.liked.include?(current_user)
      flash[:notice] = "You already liked this post."
      redirect_to post_path(@post)
    else
      @comment.liked << current_user
      flash[:notice] = "You liked this post."
      redirect_to post_path(@post)
    end
  end

  def edit
    authorize @comment, :update?
  end

  def update
    authorize @comment, :update?
    if @comment.update(comment_params)
      flash[:notice] = "Comment has been updated."
      redirect_to post_path(@post)
    else
      flash.now[:alert] = "Comment has not been updated."
      render "edit"
    end
  end

  def destroy
    authorize @comment, :destroy?
    @comment.destroy

    flash[:notice] = "Comment has been deleted."
    redirect_to post_path(@post)
  end

  private
  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
