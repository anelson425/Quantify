require 'oauth2'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    client = OAuth2::Client.new('15075', 'e251bd49ab45ec2ba2fcd1e269453910afcbd200', :site => 'https://www.strava.com/oauth/authorize')
    redirect_to client.auth_code.authorize_url(:redirect_uri => 'http://quantify.ddns.net/callback')

    # token = client.auth_code.get_token('authorization_code_value', :redirect_uri => 'http://localhost:8080/oauth2/callback', :headers => {'Authorization' => 'Basic some_password'})
    RunningClubMailer.run_log_email.deliver
    puts 'got ourselves a token'
  end

  def callback
    logger.debug("callback called")
    logger.debug(params.inspect)
  end
end
