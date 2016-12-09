class RunningClubMailer < ApplicationMailer
  default from: 'cerner.quantify@gmail.com'

  def run_log_email()
    mail(to: 'venkatesh.sridharan@cerner.com', subject: "CHEESEBALLS!!!!")
  end
end
