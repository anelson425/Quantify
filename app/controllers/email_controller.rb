class EmailController < ApplicationController

  def send_email
    RunningClubMailer::run_log_email(params)
  end
end
