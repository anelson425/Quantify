class RunningClubMailer < ApplicationMailer
  default from: 'shiftyeyes@gmail.com'

  def run_log_email()
    mail(to: 'nathan.schile@gmail.com', subject: 'Welcome to My Awesome Site')
  end
end
