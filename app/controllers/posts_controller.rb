class PostsController < ApplicationController
  before_action :ensure_logged_in
  before_action :ensure_author, only: :update

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    # @post.sub(params[:sub_id])
    @post.author = current_user
    if @post.save
      redirect_to sub_url(@post.sub)
    else
      render :new
    end
  end

  def new
    @post = Post.new
    @subs = Sub.all
    @sub = Sub.find(params[:sub_id])
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
    @subs = Sub.all
    @sub = @post.sub
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to sub_url(@post.sub)
    else
      render :edit
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :content, :url, :sub_id)
    end

    def ensure_author
      post = Post.find(params[:id])
      redirect_to sub_url(post.sub) if current_user != post.author
    end
end
