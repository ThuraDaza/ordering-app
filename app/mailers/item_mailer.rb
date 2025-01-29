class ItemMailer < ApplicationMailer
  def send_mail
    @new_item = params[:item]
    @logged_in_chef = params[:logged_in_chef]
    mail to: @logged_in_chef.email
  end
end
