class WaiterPasswordResetController < ApplicationController
  def create
    @waiter = WaiterService.find_by_email(params[:email])

    if @waiter.present?
      WaiterPasswordMailer.with(waiter: @waiter).reset.deliver_now
    end
    redirect_to root_path, alert: "We have sent reset password links to your mail"
  end

  def edit
    @waiter = Waiter.find_signed!(params[:token], purpose: "password_reset")
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to root_path, notice: "Your token have expired.Try Again"
  end

  def update
    @waiter = Waiter.find_signed!(params[:token], purpose: "password_reset")

    if @waiter.update(password_params)
      redirect_to root_path, alert: "Your password was reset successfully.Please login Again"
    else
      @message = "Confirmation password does not match password."
      render :edit
    end
  end

  private

  def password_params
    params.require(:waiter).permit(:password, :password_confirmation)
  end
end
