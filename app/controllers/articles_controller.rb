class ArticlesController < ApplicationController
  # before_action :get_user, only: :show

  def index
    # if params[:user_id]
    #   @articles = User.find(params[:user_id]).articles.order(:updated_at)
    # else
      @articles = Article.all.order(:updated_at)
      # Need this to list user (author) of each article rather than actually doing
      # The find inside the view
      @users = User.all
    # end
  end

  def show
    @article = Article.find(params[:id])
    @user = User.find(params[:user_id])
  end

  def new
    @article = Article.new
    @user = User.find(params[:user_id])
  end

  def create
    @article = Article.create!(article_params)
    @user = User.find(params[:user_id])
    @user.articles << @article
    if @user.save
      flash[:notice] = "Article created!"
      redirect_to @user
    else
      flash.now[:error] = @user.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
    @user = User.find(params[:user_id])
  end

  def update
    @article = Article.find(params[:id])
    @article.assign_attributes(article_params)
    if @article.save
      flash[:notice] = "Article created!"
      redirect_to action: :show
    else
      flash.now[:error] = @user.errors.full_messages.join(', ')
      render :new
    end
  end

  private
  def article_params
    params.require(:article).permit(:title, :body)
  end
  # def get_user
  #   @user = User.find(params[:user_id])
  # end
end
