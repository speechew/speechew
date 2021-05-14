# frozen_string_literal: true

class SuggestionPanelController < ApplicationController
  load_and_authorize_resource
  def index
    session[:conversations] ||= []
    @conversations = Conversation.includes(:recipient,
                                           :messages).joins('LEFT JOIN messages ON (messages.id = (SELECT MAX(id) FROM messages WHERE (messages.conversation_id = conversations.id)))').where.not('messages.user_id = 1').where(read: false)

    @users = User.all.where.not(id: current_user)
  end
end
