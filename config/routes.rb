Rails.application.routes.draw do
  root to: 'application#index'
  get '/mileage' => 'application#mileage'
end
