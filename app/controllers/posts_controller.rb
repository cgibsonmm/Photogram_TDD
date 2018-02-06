class PostsController < ApplicationController
  before_action :authenticate_user!

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
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = "Post updated!"
      redirect_to @post
    else
      flash[:alert] = "Error updating post!"
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
    flash[:success] = 'Post deleted!'
  end

  private

  def post_params
    params.require(:post).permit(:image, :caption)
  end
end
