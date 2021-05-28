# frozen_string_literal: true

class FeedbacksController < ApplicationController
  load_and_authorize_resource
  before_action :set_feedback, only: %i[show edit update destroy]
  respond_to :html, :js, :json

  def index
    respond_to do |format|
      format.html
      format.json { render json: FeedbackDatatable.new(view_context, { ca: current_user }) }
    end
  end

  def show; end

  def new
    @feedback = Feedback.new
  end

  def edit; end

  def create
    @feedback = Feedback.new(feedback_params)
    @feedback.save
  end

  def update
    @feedback.update(feedback_params)
    respond_with(@feedback)
  end

  def destroy
    @feedback.deleted = 1
    @feedback.save
  end

  private

  def set_feedback
    @feedback = Feedback.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def feedback_params
    params.require(:feedback).permit(:given_to_id, :given_by_id, :fluency, :vocabulary, :grammar,
                                     :notes)
  end
end
