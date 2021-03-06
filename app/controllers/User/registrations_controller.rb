# frozen_string_literal: true

module User
  class RegistrationsController < Devise::RegistrationsController
    # before_action :configure_sign_up_params, only: [:create]
    # before_action :configure_account_update_params, only: [:update]

    # GET /resource/sign_up
    # def new
    #   super
    # end

    # POST /resource
    def create
      @user = User.new(sign_up_params)
      if @user.save
        @user.add_role 'student'
        redirect_to new_user_session_path,
                    notice: 'You have to confirm your email address before continuing.'
      else
        render layout: false
      end
    end

    # GET /resource/edit
    # def edit
    #   super
    # end

    # PUT /resource
    def update
      @user = User.find(current_user.id)
      @form_type = nil
      if current_user.can? :update, @user
        if !params[:user][:profile].nil?
          @user.update(update_profile_params)
          sign_in @user
          @form_type = 'profile'
        elsif !params[:user][:change_password].nil?
          if @user.valid_password?(params[:user][:current_password])
            if @user.update(update_password_params)
              bypass_sign_in @user
            else
              sign_in @user
            end
          else
            @user.errors.add(:base, 'Your current password is incorrect.')
            if params[:user][:password] != params[:user][:password_confirmation]
              @user.errors.add(:base, "Password confirmation doesn't match Password")
            end
          end
          @form_type = 'password'
        end
        render layout: false
      else
        redirect_to(root_url,
                    { flash: { error: 'You are not authorized to perform this action!' } })
      end
    end

    # DELETE /resource
    # def destroy
    #   super
    # end

    # GET /resource/cancel
    # Forces the session data which is usually expired after sign
    # in to be expired now. This is useful if the user wants to
    # cancel oauth signing in/up in the middle of the process,
    # removing all OAuth session data.
    # def cancel
    #   super
    # end

    protected

    # If you have extra params to permit, append them to the sanitizer.
    def sign_up_params
      params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :dob, :gender,
                                   :bio, :country_id, :language_id)
    end

    def update_password_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def update_profile_params
      params.require(:user).permit(:first_name, :last_name, :dob, :gender, :bio, :country_id,
                                   :language_id)
    end

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_account_update_params
    #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
    # end

    # The path used after sign up.
    def after_sign_up_path_for(_resource)
      flash[:notice] = 'Welcome! Please follow the steps!'
      if current_user.has_role? :admin
        dashboard_path
      else
        root_path
      end
    end

    # The path used after sign up for inactive accounts.
    # def after_inactive_sign_up_path_for(resource)
    #   super(resource)
    # end
  end
end
