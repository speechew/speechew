class KnowledgeBooksController < ApplicationController
  load_and_authorize_resource
  before_action :set_knowledge_book, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js, :json
  
  def index
	respond_to do |format|
      format.html
      format.json { render json: KnowledgeBookDatatable.new(view_context, {ca: current_user}) }
    end
  end

  def show
  end

  def new
    @knowledge_book = KnowledgeBook.new
  end

  def edit
  end

  def create
    @knowledge_book = KnowledgeBook.new(knowledge_book_params)
    if @knowledge_book.save
      redirect_to knowledge_books_path, notice: "Knowledge book successfully created."
    end
  end

  def update
    if @knowledge_book.update(knowledge_book_params)
      redirect_to knowledge_books_path, notice: "Knowledge book successfully updated."
    end
  end

  def destroy
    @knowledge_book.deleted = 1
	  @knowledge_book.save
  end

  private
    def set_knowledge_book
      @knowledge_book = KnowledgeBook.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def knowledge_book_params
      params.require(:knowledge_book).permit(:code, :title, :content, knowledge_chapters_attributes: [:id, :title, :content, :_destroy])
    end
end
