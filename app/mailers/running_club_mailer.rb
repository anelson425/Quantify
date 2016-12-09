class RunningClubMailer < ApplicationMailer
  default from: 'cerner.quantify@gmail.com'

  def run_log_email(size, athlete, activities)
    @athlete = eval(athlete)
    @size = size
    @activities = Array.new
    activities.each do |a|
      b = JSON.load a
      @activities = @activities << b
    end
    mail(to: 'andy.nelson@cerner.com', subject: "#{@athlete['firstname']} #{@athlete['lastname']} - Tracking Card Submission")
  end
end
