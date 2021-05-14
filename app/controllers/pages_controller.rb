# frozen_string_literal: true

class PagesController < ApplicationController
  load_and_authorize_resource
  before_action :set_page, only: %i[show edit update destroy]
  respond_to :html, :js, :json

  def index
    respond_to do |format|
      format.html
      format.json { render json: PageDatatable.new(view_context, { ca: current_user }) }
    end
  end

  def show; end

  def new
    @page = Page.new
  end

  def edit; end

  def create
    @page = Page.new(page_params)
    @page.save
  end

  def update
    @page.update(page_params)
    respond_with(@page)
  end

  def destroy
    @page.deleted = 1
    @page.save
  end

  private

  def set_page
    @page = Page.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def page_params
    params.require(:page).permit(:code, :title, :content)
  end
end
