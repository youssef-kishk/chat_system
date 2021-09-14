class Message < ApplicationRecord
    belongs_to :chat
    validates :body, presence: true

    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks


    def self.search_msg(chat_id,msg_body)
        self.search({
          query: {
            bool: {
              must: [
              {
                multi_match: {
                  query: msg_body,
                  fields: [:body]
                }
              },
              {
                match: {chat_id: chat_id}
              }]
            }
          }
        }).records
      end
end
