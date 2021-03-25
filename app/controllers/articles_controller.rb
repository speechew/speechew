class ArticlesController < ApplicationController
  load_and_authorize_resource
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js, :json
  
  def index
	@articles = Article.where(:deleted => false).where(:status => "Published").paginate(page: params[:page], per_page: 6)
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to article_path(@article), notice: "Article successfully created."
    end
  end

  def update
    if @article.update(article_params)
      redirect_to article_path(@article), notice: "Article successfully updated."
    end
  end

  def destroy
    @article.deleted = 1
	  @article.save
  end

  def my_articles
    respond_to do |format|
      format.html
      format.json { render json: ArticleDatatable.new(view_context, {ca: current_user}) }
    end
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def article_params
      params.require(:article).permit(:title, :content, :status, :about, category_ids: [])
    end
end
