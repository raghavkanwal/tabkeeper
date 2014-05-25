class UsersController < ApplicationController
  def new
  	@user = User.new
  end
  
  def show
    redirect_to root_url if current_user.blank?
    flash[:notice] = "Please log in to view this page"
    @user = User.find(params[:id])
    @bill = @user.bills
    @debt = @user.debts
  end

  def create
  	@user = User.new(user_params)

  	if @user.save
  		redirect_to root_url, :notice => "Signed Up!"
  	else
  		render "new"
  	end
  end

  private
  
  def user_params
      params.require(:user).permit(:email, :password, :password_confirmation,:firstname,:lastname)
    end

end
