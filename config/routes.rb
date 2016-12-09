Rails.application.routes.draw do
  root to: 'application#index'
  get '/mileage' => 'application#mileage'
  get '/email' => 'running_club_mailer#run_log_email'
end
