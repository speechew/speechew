# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags 'ActionCable', "User #{current_user.id}" if current_user
    end

    protected

    def find_verified_user
      return unless current_user == env['warden'].user
    end
  end
end
