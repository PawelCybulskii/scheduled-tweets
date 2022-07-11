# frozen_string_literal: true

class PasswordResetsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(email: params[:email])

    if @user.present?
      # Send email. Deliver_later sends in background, deliver_now sends now,
      # but response would be bit longer
      PasswordMailer.with(user: @user).reset.deliver_now
    end

    redirect_to root_path, notice: 'If an account with this email was found, we have sent link to reset your password '
  end

  def edit
    @user = User.find_signed!(params[:token], purpose: 'password_reset')
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to sign_in_path, alert: 'Your token has expired. Please try again.'
  end

  def update
    # line below checks if user is actually logged in and token time validity
    @user = User.find_signed(params[:token], purpose: 'password_reset')
    if @user.update(password_params)
      redirect_to sign_in_path, notice: 'Your password was reset successfully. Please sign in.'
    else
      render :edit
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
