# frozen_string_literal: true

class AdminActionsReflex < ApplicationReflex
   delegate :current_ability, to: :controller

  # Add Reflex methods in this file.
  #
  # All Reflex instances expose the following properties:
  #
  #   - connection - the ActionCable connection
  #   - channel - the ActionCable channel
  #   - request - an ActionDispatch::Request proxy for the socket connection
  #   - session - the ActionDispatch::Session store for the current visitor
  #   - url - the URL of the page that triggered the reflex
  #   - element - a Hash like object that represents the HTML element that triggered the reflex
  #
  # Example:
  #
  #   def example(argument=true)
  #     # Your logic here...
  #     # Any declared instance variables will be made available to the Rails controller and view.
  #   end
  #
  # Learn more at: https://docs.stimulusreflex.com

  def toggle
    user = User.find(element.dataset[:id])
    user.update(blocked: (user.blocked? ? false : true))
  end

  def toggle_editor
    user = User.find(element.dataset[:id])
    if user.has_role? :editor
      user.remove_role "editor"
    else
      user.add_role "editor"
    end
  end

  def toggle_tutor
    user = User.find(element.dataset[:id])
    if user.has_role? :tutor
      user.remove_role "tutor"
    else
      user.add_role "tutor"
    end
  end
end