class StravaController < ApplicationController

  def index
    #Todo find a way to use better oauth and not hardcode people's token blindly.(ugh!!)
    @client = Strava::Api::V3::Client.new(:access_token => '1b375a9f5a846cee6277e65974b116c809c3c6c4')
    args = {"after" => Time.gm(Time.now.year, 'dec', '1').to_i}
    @strava_activities = @client.list_athlete_activities(args)
    @activities = []
    total_miles = 0
    @strava_activities.each do |activity|
      if activity['type'].eql? 'Run'
        distance = (activity['distance'].to_f * (0.000621371)).round(2)
        total_miles += distance
        puts distance
        puts total_miles
        @activities << Activity.new(date: activity['start_date_local'], distance_mi: distance, time_min: ((activity['moving_time'].to_i)/60).round(2), total_distance_mi: total_miles)
      end
    end
  end

  def show
    #Calls the athlete information to get the runs for that year

  end

end