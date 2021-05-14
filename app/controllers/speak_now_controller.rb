# frozen_string_literal: true

class SpeakNowController < ApplicationController
  load_and_authorize_resource
  def index
    if !params[:call].nil? && (params[:call] == 'true') && !current_user.partner_token.nil? && (current_user.partner_token_expiry > Time.now)
      current_user.update(in_call: true)
    end
  end
end
