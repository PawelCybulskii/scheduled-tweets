
class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
# this will print out all user parameters which were put in the form
#    render plain: params[:user]
# private method is used beacuse it is safer than using direct data. to create user from the form:
    @user = User.new(user_params)
    if @user.save
      # cookies provided by rails can be encrypted, like session cookies. or sign cookies. 
      # so instead of cookies(:user_id) session(:user_id) should be used.
      # Also what's really important is that it needs to be secured from editting from internet browser.
      # Therefor it must equal actuall logged user: session(:user_id) = @user.id
      # This allows to use it from main controller and print that out.
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Successfully created account"
    else
      flash[:alert] = "Something went wrong"
      render :new
    end
  end

private
# permit is for only allowed 
def user_params
  params.require(:user).permit(:email, :password, :password_confirmation)
end

end
