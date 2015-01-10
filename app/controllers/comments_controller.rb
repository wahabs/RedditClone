class CommentsController < ApplicationController

  def new
    @comment = Comment.new
    @post_id = params[:post_id]
    render :new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user
    if @comment.save
      redirect_to post_url(@comment.post)
    else
      render :new
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end


  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_id)
  end

end
