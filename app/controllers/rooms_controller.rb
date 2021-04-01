class RoomsController < ApplicationController
  load_and_authorize_resource
  before_action :set_room, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js, :json
  
  def index
	respond_to do |format|
      format.html
      format.json { render json: RoomDatatable.new(view_context, {ca: current_user}) }
    end
  end

  def show
  end

  def new
    @room = Room.new
  end

  def edit
  end

  def create
    @room = Room.new(room_params)
    @room.save
  end

  def update
    @room.update(room_params)
    respond_with(@room)
  end

  def destroy
    @room.deleted = 1
	  @room.save
  end

  def create_room
    if User.online.count < 2
      ActionCable.server.broadcast('notification-'+current_user.id.to_s+'', message: 'No users online. Try again after some time.')
    else
      @room = Room.create(:name => SecureRandom.hex(20))
    end
    render layout: false
  end

  def search_partner
    user = User.where.not(:id => current_user.id).online.sample
    current_user.update(:in_call => true,:partner_token => params[:partner_token],:partner_token_expiry => Time.now+10.seconds)
    user.update(:in_call => true,:partner_token => params[:partner_token],:partner_token_expiry => Time.now+10.seconds)
    ActionCable.server.broadcast('notification-'+user.id.to_s+'', message: 'incoming')
    render layout: false
  end

  private
    def set_room
      @room = Room.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def room_params
      params.require(:room).permit(:name)
    end
end
