require 'pry'
class RunningClubMailer < ApplicationMailer
  default from: 'cerner.quantify@gmail.com'

  def run_log_email(size, athlete, activities)
    @athlete = athlete
    @shirt_size = size
    @activities = Array.new
    activities.each do |a|
      b = JSON.load a
      @activities = @activities << b
    end
    binding.pry
    mail(to: 'ian.kottman@cerner.com', subject: "#{athlete['firstname']} #{athlete['lastname']} - Tracking Card Submission")
  end
end
