Rails.application.routes.draw do
  root "messages#root"
  resources :messages, only: [:create]
  get 'messages/:digest' => "messages#digest"
end
