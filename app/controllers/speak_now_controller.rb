class SpeakNowController < ApplicationController
  load_and_authorize_resource
  def index
  	if !params[:call].nil? and params[:call] == "true" and !current_user.partner_token.nil? and current_user.partner_token_expiry > Time.now 
  		current_user.update(:in_call => true)
  	end 
  end
end
