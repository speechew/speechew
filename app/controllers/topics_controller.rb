# frozen_string_literal: true

class TopicsController < ApplicationController
  load_and_authorize_resource
  before_action :set_topic, only: %i[show edit update destroy]
  respond_to :html, :js, :json

  def index
    respond_to do |format|
      format.html
      format.json { render json: TopicDatatable.new(view_context, { ca: current_user }) }
    end
  end

  def show; end

  def new
    @topic = Topic.new
  end

  def edit; end

  def create
    @topic = Topic.new(topic_params)
    @topic.save
  end

  def update
    @topic.update(topic_params)
    respond_with(@topic)
  end

  def destroy
    @topic.deleted = 1
    @topic.save
  end

  private

  def set_topic
    @topic = Topic.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def topic_params
    params.require(:topic).permit(:name)
  end
end
