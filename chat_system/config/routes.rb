Rails.application.routes.draw do
  resources :applications, only: [:index, :show, :create, :destroy, :update] do
    resources :chats, only: [:index, :show, :create, :destroy] do
      resources :messages, only: [:index, :show, :create, :destroy, :update]
    end
  end
end
