Rails.application.routes.draw do
  get '/departments', to: 'departments#index'

  get '/employees/:id', to: 'employees#show'
  post '/employees/:id', to: 'employee_tickets#create'
end
