class QuestionSetsController < ApplicationController
  load_and_authorize_resource
  before_action :set_question_set, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js, :json
  
  def index
	respond_to do |format|
      format.html
      format.json { render json: QuestionSetDatatable.new(view_context, {ca: current_user}) }
    end
  end

  def show
  end

  def new
    @question_set = QuestionSet.new
  end

  def edit
  end

  def create
    @question_set = QuestionSet.new(question_set_params)
    @question_set.save
  end

  def update
    @question_set.update(question_set_params)
    respond_with(@question_set)
  end

  def destroy
    @question_set.deleted = 1
	  @question_set.save
  end

  private
    def set_question_set
      @question_set = QuestionSet.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def question_set_params
      params.require(:question_set).permit(:title, topic_ids: [])
    end
end
