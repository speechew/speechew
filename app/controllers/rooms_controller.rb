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
      ActionCable.server.broadcast('notification-'+current_user.id.to_s+'', message: 'no_users_online')
    else
      @room = Room.create(:name => SecureRandom.hex(20))
    end
    render layout: false
  end

  def search_partner
    receiver = User.where.not(:id => current_user.id).online
    if receiver.empty?
      ActionCable.server.broadcast('notification-'+current_user.id.to_s+'', message: 'no_users_online')
    else
      receiver = receiver.sample
      current_user.update(:in_call => true,:partner_token => params[:partner_token],:partner_token_expiry => Time.now+10.seconds,:search_partner_try => 1)
      receiver.update(:in_call => true,:partner_token => params[:partner_token],:partner_token_expiry => Time.now+10.seconds)
      ActionCable.server.broadcast('notification-'+receiver.id.to_s+'', message: 'incoming_call')
    end
    render layout: false
  end

  def decline_call
    call_maker = User.where(:partner_token => current_user.partner_token).first
    current_user.update(:in_call => false,:partner_token => nil,:partner_token_expiry => nil,:search_partner_try => 0)
    if call_maker.search_partner_try > 3
      ActionCable.server.broadcast('notification-'+call_maker.id.to_s+'', message: 'all_users_busy')
      call_maker.update(:in_call => false,:partner_token => nil,:partner_token_expiry => nil,:search_partner_try => 0)
    else
      new_receiver = User.where.not(:id => [current_user.id,call_maker.id]).online
      if new_receiver.empty?
        ActionCable.server.broadcast('notification-'+call_maker.id.to_s+'', message: 'all_users_busy')
        call_maker.update(:in_call => false,:partner_token => nil,:partner_token_expiry => nil,:search_partner_try => 0)
      else
        new_receiver = new_receiver.sample
        new_receiver.update(:in_call => true,:partner_token => call_maker.partner_token,:partner_token_expiry => Time.now+10.seconds)
        ActionCable.server.broadcast('notification-'+new_receiver.id.to_s+'', message: 'incoming_call')
        call_maker.update(:search_partner_try => call_maker.search_partner_try+1)
      end 
    end
    render layout: false
  end

  def free_user
    current_user.update(:in_call => false,:partner_token => nil,:partner_token_expiry => nil,:search_partner_try => 0)
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
