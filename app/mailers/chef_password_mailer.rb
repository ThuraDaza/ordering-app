class ChefPasswordMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.chef_password_mailer.reset.subject
  #
  def reset
    @token = params[:chef].signed_id(purpose: "password_reset", expires_in: 15.minutes)

    mail to: params[:chef].email
  end
end
