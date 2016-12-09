Rails.application.routes.draw do
  root to: 'application#index'
  get '/mileage' => 'application#mileage'
  post '/email' => 'email#send_email'
end
