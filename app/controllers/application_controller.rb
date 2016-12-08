require 'oauth2'
require 'httparty'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  REDIRECT_URL = "http://quantify.ddns.net/mileage".freeze

  before_action :initialize_oauth_client

  def index
    redirect_to @oauth_client.auth_code.authorize_url(:redirect_uri => REDIRECT_URL)

    #RunningClubMailer.run_log_email.deliver
  end

  def mileage
    logger.debug("in mileage")
    oauth_token = @oauth_client.auth_code.get_token(params[:code], :redirect_uri => REDIRECT_URL).token
    @client = Strava::Api::V3::Client.new(:access_token => oauth_token)
    #Start from the beggining of the year till the day you login to the application
    @strava_activities = []
    @strava_activities_page = @client.list_athlete_activities({:after => Time.gm(Time.now.year, 'jan', '1').to_i})
    while true
      @strava_activities += @strava_activities_page
      @strava_activities_page = @client.list_athlete_activities({:after => Time.parse(@strava_activities_page.last['start_date_local']).gmtime.to_i})
      if @strava_activities_page.empty?
        break
      end
    end

    @activities = []
    total_miles = 0
    @strava_activities.each do |activity|
      if activity['type'].eql? 'Run'
        distance = (activity['distance'].to_f * (0.000621371)).round(2)
        total_miles += distance
        @activities << Activity.new(date: activity['start_date_local'], distance_mi: distance, time_min: ((activity['moving_time'].to_i)/60).round(2), total_distance_mi: total_miles)
      end
    end
  end

  def initialize_oauth_client
    @oauth_client = OAuth2::Client.new('15075', 'e251bd49ab45ec2ba2fcd1e269453910afcbd200', :site => 'https://www.strava.com/oauth/authorize')
  end
end
