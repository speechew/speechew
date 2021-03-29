class UsersListController < ApplicationController
  load_and_authorize_resource
  def index
  	respond_to do |format|
      format.html
      format.json { render json: UserDatatable.new(view_context, {ca: current_user}) }
    end
  end
end
