class AskDoubtController < ApplicationController
  load_and_authorize_resource
  def index
  	session[:conversations] ||= []

    @users = User.all.where.not(id: current_user)
    @conversations = Conversation.includes(:recipient, :messages)
                                 .find(session[:conversations])
  end
end
