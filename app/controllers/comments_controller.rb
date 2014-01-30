class CommentsController < ApplicationController
  def index
    @article = Article.find(params[:article_id])
    @comments = @article.comments
  end

  def show
  end

  def new
    @comment = Comment.new
    @article = Article.find(params[:article_id])
    @user = User.find(params[:user_id])
  end

  def create
    @comment = Comment.create!(comment_params)
    @article = Article.find(params[:article_id])
    @article.comments << @comment
    if @article.save
      flash[:notice] = "Comment added!"
      redirect_to user_article_path(@article.user_id, @article.id)
    else
      flash.now[:error] = @comment.errors.full_messages.join(', ')
      render :new
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
