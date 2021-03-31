class MessagesController < ApplicationController
  load_and_authorize_resource
  def create
    @conversation = Conversation.includes(:recipient).find(params[:message][:conversation_id])
    @message = @conversation.messages.create(message_params)

    respond_to do |format|
      format.js
    end
  end

  private

  def message_params
    params.require(:message).permit(:conversation_id,:user_id, :body)
  end
end