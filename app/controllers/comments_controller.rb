class CommentsController < ApplicationController
  def index
    @article = Article.find(params[:article_id])
    @comments = @article.comments
    end
  end

  def show
  end

  def new
  end

  def create
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
