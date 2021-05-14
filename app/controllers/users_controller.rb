# frozen_string_literal: true

class UsersController < ApplicationController
  load_and_authorize_resource
  add_breadcrumb 'Users', :users_list_path
  def user_view
    @user = User.find(params[:id])
    add_breadcrumb (@user.full_name.nil? ? @user.email : @user.full_name).to_s, user_view_path(@user)
  end
end
