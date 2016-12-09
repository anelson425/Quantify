class EmailController < ApplicationController

  skip_before_filter  :verify_authenticity_token

  def send_email
    logger.debug('SENDING THE EMMAAAAAAIL')
    logger.debug(ENV['QUANTIFY_EMAIL_USER_NAME'])
    logger.debug(ENV['QUANTIFY_EMAIL_PASSWORD'])
    RunningClubMailer.run_log_email(params[:size], params[:athlete], params[:activities]).deliver
  end
end
