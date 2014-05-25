class DebtsController < ApplicationController

  # GET /debts
  # GET /debts.json
  def index
    @debts = Debt.all
  end

  # GET /debts/1
  # GET /debts/1.json
  def show
  end

  # GET /debts/new
  def new
    @debt = Debt.new
  end

  # GET /debts/1/edit
  def edit
  end

  # POST /debts
  # POST /debts.json
   def create
    @user = current_user
    @debt = @user.debts.build(debt_params)
    if @debt.save
      redirect_to user_path(:id => current_user.id), :notice => "Debt created!"
    else
      redirect_to user_path(:id => current_user.id), :notice => "Debt not Created!"
    end
  end

  # PATCH/PUT /debts/1
  # PATCH/PUT /debts/1.json
  def update
    @user = current_user
    @debt = @user.debts.find_by(params[:id])
    if @debt.save
      redirect_to user_path(:id => current_user.id), :notice => "Debt Updated!"
    else
      redirect_to user_path(:id => current_user.id), :notice => "Debt not Updated!"
    end
  end

  # DELETE /debts/1
  # DELETE /debts/1.json
  def destroy
    @user = current_user
    @debt = @user.debts.find_by(params[:id])
    @debt.destroy
    respond_to do |format|
      format.html { redirect_to user_path(:id => current_user.id), notice: 'Debt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


    # Never trust parameters from the scary internet, only allow the white list through.
    def debt_params
      params.require(:debt).permit(:to, :amount, :user_id)
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
