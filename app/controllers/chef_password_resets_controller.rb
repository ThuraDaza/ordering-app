class ChefPasswordResetsController < ApplicationController
  def create
    @chef = ChefService.find_by_email(params[:email])

    if @chef.present?
      ChefPasswordMailer.with(chef: @chef).reset.deliver_now
    end
    redirect_to chef_login_path, alert: "We have sent reset password links to your mail"
  end

  def edit
    @chef = Chef.find_signed!(params[:token], purpose: "password_reset")
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to chef_login_path, notice: "Your token have expired.Try Again"
  end

  def update
    @chef = Chef.find_signed!(params[:token], purpose: "password_reset")

    if @chef.update(password_params)
      redirect_to chef_login_path, alert: "Your password was reset successfully.Please login Again"
    else
      @message = "Confirmation password does not match password."
      render :edit
    end
  end

  private

  def password_params
    params.require(:chef).permit(:password, :password_confirmation)
  end
end
