class HandleMessageWorker
    include Sidekiq::Worker
    sidekiq_options retry: false
  
    def perform(number,chat_id,body)
        msg = Message.new(number: number, chat_id: chat_id, body: body)
        msg.save
    end
    
  end