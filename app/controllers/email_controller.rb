class EmailController < ApplicationController

  skip_before_filter  :verify_authenticity_token

  def send_email
    RunningClubMailer.run_log_email(params[:size], params[:athlete], params[:activities]).deliver
    redirect_to root_url and return
  end
end
