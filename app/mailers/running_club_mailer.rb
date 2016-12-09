class RunningClubMailer < ApplicationMailer
  default from: 'cerner.quantify@gmail.com'

  def run_log_email(size, athlete, activities)
    @athlete = athlete
    @shirt_size = size
    @activities = activities
    mail(to: athlete.email, subject: "#{athlete.firstname} #{athlete.lastname} - Tracking Card Submission")
  end
end
