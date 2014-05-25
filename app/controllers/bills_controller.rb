class BillsController < ApplicationController
  before_action :correct_user,   only: :destroy

  def new
    @bill = Bill.new
  end
  def create
    @user = current_user
    @bill = @user.bills.build(bill_params)
    if @bill.save
      redirect_to user_path(:id => current_user.id), :notice => "Bill created!"
    else
      redirect_to user_path(:id => current_user.id), :notice => "Bill not Created!"
    end
  end

  def edit
    @user = current_user
    @bill = @user.bills.find_by(params[:id])
  end

  def update
    @user = current_user
    @bill = @user.bills.find_by(params[:id])
    if @bill.save
      redirect_to user_path(:id => current_user.id), :notice => "Bill Updated!"
    else
      redirect_to user_path(:id => current_user.id), :notice => "Bill not Updated!"
    end
  end

  def destroy
    @user = current_user
    @bill = @user.bills.find_by(params[:id])
    @bill.destroy
    redirect_to user_path(:id => current_user.id), :notice => "Bill Destroyed!"
  end

    def bill_params
      params.require(:bill).permit(:for, :amount, :user_id)
    end

    def correct_user
      @bill = current_user.bills
      redirect_to user_path(:id => current_user.id) if @bill.nil?
    end

    def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

   def current_user?(user)
    user == current_user
  end
end