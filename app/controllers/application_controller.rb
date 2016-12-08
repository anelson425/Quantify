require 'oauth2'
require 'httparty'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    client = OAuth2::Client.new('15075', 'e251bd49ab45ec2ba2fcd1e269453910afcbd200', :site => 'https://www.strava.com/oauth/authorize')
    redirect_to client.auth_code.authorize_url(:redirect_uri => 'http://quantify.ddns.net/callback')

    RunningClubMailer.run_log_email.deliver
  end

  def callback
    logger.debug("callback called")
    # the auth token is in the 'code' parameter
    code = params[:code]
    client = OAuth2::Client.new('15075', 'e251bd49ab45ec2ba2fcd1e269453910afcbd200', :site => 'https://www.strava.com/oauth/authorize')
    token = client.auth_code.get_token(code, :redirect_uri => 'http://quantify.ddns.net/callback')
    logger.debug("got a token")
    logger.debug(token)
  end
end
