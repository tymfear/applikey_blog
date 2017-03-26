class ArticlesController < ApplicationController
  before_action :authorize
  before_action :load_article, only: %i(show edit update destroy)
  before_action :verify_owner, only: %i(edit update destroy)
  
  def new
    @article = Article.new
  end
  
  def show
    @comments = @article.comments.includes(:user).group_by &:comment_id
  end
  
  def index
    @articles = Article.all
  end
  
  def edit
  end
  
  def create
    @article      = Article.new article_params
    @article.user = current_user
    
    return render :new unless @article.save
    
    redirect_to @article, notice: t('success.create', model: 'Article')
  end
  
  def update
    @article.update article_params
    
    return render :edit if @article.errors.any?
    
    redirect_to @article, notice: t('success.update', model: 'Article')
  end
  
  def destroy
    @article.destroy
    
    return render :show if @article.errors.any?
    
    redirect_to articles_path, notice: t('success.destroy', model: 'Article')
  end
  
  private
  
  def load_article
    @article = Article.includes(:user).find(params[:id])
  end
  
  def article_params
    params.require(:article).permit %i(title body)
  end
  
  def verify_owner
    return if my_item? @article
    
    raise ActionController::RoutingError.new t('errors.not_found')
  end
end
