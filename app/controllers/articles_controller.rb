# frozen_string_literal: true

class ArticlesController < ApplicationController
  load_and_authorize_resource
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_article, only: %i[show edit update destroy]
  respond_to :html, :js, :json

  add_breadcrumb 'Articles', '/articles '

  def index
    if params[:category].nil?
      @articles = Article.includes(:user).published.paginate(page: params[:page], per_page: 4)
    else
      category = Category.where(name: params[:category]).first
      @articles = category.articles.includes(:user).published.paginate(page: params[:page],
                                                                       per_page: 4)
      add_breadcrumb "Category: #{params[:category]}", articles_path(category: params[:category]),
                     match: :exact
    end
  end

  def show
    add_breadcrumb @article.title.to_s, article_path(@article)
  end

  def new
    @article = Article.new
  end

  def edit; end

  def create
    @article = Article.new(article_params)
    redirect_to article_path(@article), notice: 'Article successfully created.' if @article.save
  end

  def update
    if @article.update(article_params)
      redirect_to article_path(@article), notice: 'Article successfully updated.'
    end
  end

  def destroy
    @article.deleted = 1
    @article.save
  end

  def my_articles
    respond_to do |format|
      format.html
      format.json { render json: ArticleDatatable.new(view_context, { ca: current_user }) }
    end
  end

  def review_articles
    respond_to do |format|
      format.html
      format.json { render json: ArticleDatatable.new(view_context, { ca: current_user }) }
    end
  end

  def all_articles
    respond_to do |format|
      format.html
      format.json { render json: ArticleDatatable.new(view_context, { ca: current_user }) }
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
