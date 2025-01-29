# Preview all emails at http://localhost:3000/rails/mailers/chef_password_mailer
class ChefPasswordMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/chef_password_mailer/reset
  def reset
    ChefPasswordMailer.reset
  end

end
