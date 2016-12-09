class EmailController < ApplicationController

  skip_before_filter  :verify_authenticity_token

  def send_email
    puts params
    RunningClubMailer.run_log_email(params).deliver
  end
end
