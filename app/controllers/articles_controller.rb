class ArticlesController < ApplicationController
  # before_action :get_user, only: :show

  def index
    if params[:user_id]
      @articles = User.find(:user_id).articles
    else
      @articles = Article.all.order(:user_id)
    end
  end

  def show
    @article = Article.find(params[:id])
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
  end

  private
  def article_params
    params.require(:article).permit(:title, :body)
  end
  # def get_user
  #   @user = User.find(params[:user_id])
  # end
end
