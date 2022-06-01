class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user.present?
      # Send email. Deliver_later sends in background
      PasswordMailer.with(user: @user).reset.deliver_later
    else
    end
    redirect_to root_path, notice: "If an account with this email was found, we have sent link with reset password "
  end

  def edit
    @user = User.find_signed(params[:token], purpose: "password_reset")
  end
end
