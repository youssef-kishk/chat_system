Rails.application.routes.draw do
  resources :applications, only: [:index, :show, :create, :destroy, :update] do
    resources :chats, only: [:index, :show, :create, :destroy] do
      resources :messages, only: [:index, :show, :create, :destroy, :update] do
        collection do
          get 'search'
        end
      end
    end
  end
end
