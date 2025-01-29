# Preview all emails at http://localhost:3000/rails/mailers/waiter_password_mailer
class WaiterPasswordMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/waiter_password_mailer/reset
  def reset
    WaiterPasswordMailer.reset
  end

end
