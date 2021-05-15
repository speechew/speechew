# frozen_string_literal: true

module ApplicationHelper
  def bootstrap_flash_translate(type, msg)
    case type
    when 'notice'
      'info'
    when 'error'
      'danger'
    when 'alert'
      if msg == 'You need to sign in or sign up before continuing.'
        'info'
      else
        'danger'
      end
    else
      type
    end
  end
  def display_as_badges(arr,type)
    badges = ""
    if arr.any? and !type.blank?
      arr.each do |name|
        badges += '<span class="badge badge-pill badge-'+type+' mr-1">'+name+'</span>'
      end
    end
    return badges
  end
end
