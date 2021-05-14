# frozen_string_literal: true

class LanguagesController < ApplicationController
  load_and_authorize_resource
  before_action :set_language, only: %i[show edit update destroy]
  respond_to :html, :js, :json

  def index
    respond_to do |format|
      format.html
      format.json { render json: LanguageDatatable.new(view_context, { ca: current_user }) }
    end
  end

  def show; end

  def new
    @language = Language.new
  end

  def edit; end

  def create
    @language = Language.new(language_params)
    @language.save
  end

  def update
    @language.update(language_params)
    respond_with(@language)
  end

  def destroy
    @language.deleted = 1
    @language.save
  end

  private

  def set_language
    @language = Language.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def language_params
    params.require(:language).permit(:name, :language_code)
  end
end
