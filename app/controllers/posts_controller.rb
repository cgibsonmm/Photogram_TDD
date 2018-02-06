class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :post_owner, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all.order('created_at DESC')
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Your post has been created."
      redirect_to @post
    else
      flash[:alert] = "You need a photo to create post!"
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Post updated!"
      redirect_to @post
    else
      flash[:alert] = "Error updating post!"
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
    flash[:success] = 'Post deleted!'
  end

  private

  def post_params
    params.require(:post).permit(:image, :caption)
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def post_owner
    unless current_user.id == @post.user.id
      flash[:alert] = 'You must own this post to edit it!'
      redirect_to root_path
    end
  end
end
