class UserSettingsController < ApplicationController
  load_and_authorize_resource
  def index
  	@conversation = Conversation.where(:sender_id => current_user.id).where(:recipient_id => User.find(1).id).first
  end
end
