class HandleChatWorker
    include Sidekiq::Worker
    sidekiq_options retry: false
  
    def perform(number,app_id)
        chat = Chat.new(number: number, application_id: app_id)
        chat.save
    end

  end