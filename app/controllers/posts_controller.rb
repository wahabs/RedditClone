class PostsController < ApplicationController
  before_action :ensure_logged_in
  before_action :ensure_author, only: :update

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    @post.sub_ids = params[:post][:sub_ids]
    if @post.save
      redirect_to post_url(@post)
    else
      render :new
    end
  end

  def new
    @post = Post.new
    @subs = Sub.all
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.where(parent_id: nil)
  end

  def edit
    @post = Post.find(params[:id])
    @subs = Sub.all
  end

  def update
    @post = Post.find(params[:id])
    @post.sub_ids = params[:post][:sub_ids]
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      render :edit
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :content, :url, :sub_ids)
    end

    def ensure_author
      post = Post.find(params[:id])
      redirect_to post_url(post) if current_user != post.author
    end
end
