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
    # @activities = [Activity.new(date: '1234123434', distance_mi: '23435', time_min: '354642', total_distance_mi: '35452')]
    # RunningClubMailer.run_log_email.deliver
  end

  def mileage
    logger.debug("in mileage")
    oauth_token = @oauth_client.auth_code.get_token(params[:code], :redirect_uri => REDIRECT_URL).token
    @client = Strava::Api::V3::Client.new(:access_token => oauth_token)
    #Start from the beginning of the year till the day you login to the application
    strava_activities = []
    page = 1
    current_year = Time.new.year

    list_athlete_activities = @client.list_athlete_activities({per_page: 200, page: page})
    year_run_activities << list_athlete_activities.select do |activity|
      Time.parse(activity[:start_date_local]).year == current_year && activity['type'] == 'Run'
    end

    until year_run_activities.size == 0
      strava_activities << year_run_activities

      page += 1
      list_athlete_activities = @client.list_athlete_activities({per_page: 200, page: page})
      year_run_activities = list_athlete_activities.select do |activity|
        Time.parse(activity[:start_date_local]).year == current_year && activity['type'] == 'Run'
      end
    end

    @activities = []
    total_miles = 0
    strava_activities.each do |activity|
      distance = (activity['distance'].to_f * (0.000621371)).round(2)
      total_miles += distance
      @activities << Activity.new(date: activity['start_date_local'], distance_mi: distance, time_min: ((activity['moving_time'].to_i)/60).round(2), total_distance_mi: total_miles.round(2))
    end
  end

  def initialize_oauth_client
    @oauth_client = OAuth2::Client.new('15075', 'e251bd49ab45ec2ba2fcd1e269453910afcbd200', :site => 'https://www.strava.com/oauth/authorize')
  end
end
