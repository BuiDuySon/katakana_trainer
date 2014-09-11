Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "sessions",
    registrations: "registrations",
    passwords: "passwords",
    omniauth_callbacks: "omniauth_callbacks"
  }
  resources :users
end
