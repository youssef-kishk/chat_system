require 'rails_helper'

describe 'Messages APIs:', type: :request do

    it 'Return all chat messages' do
        @token = "a8pYohCSZQLCWodmHcwi7eXM"
        @chat_number = "1"

        get '/applications/' + @token + '/chats/' + @chat_number + '/messages'

        expect(response).to have_http_status(:ok)
    end

    it 'Return message by number' do
        @token = "UvfVTp5wT8G5rpG2NAUPXDVL"
        @chat_number = "1"
        @msg_number = "1"

        get '/applications/'+ @token + '/chats/' + @chat_number + '/messages/' + @msg_number

        expect(response).to have_http_status(:ok)
    end

    it 'Create message' do
        @token = "erEK5aaMrmjVHNpLUoH1HDEx"
        @chat_number = "1"
        @msg_body="test body"

        post '/applications/'+ @token + '/chats/' + @chat_number + '/messages', params: {body:  @msg_body}, as: :json

        expect(response).to have_http_status(:created)
    end

    it 'Delete message' do
        @token = "erEK5aaMrmjVHNpLUoH1HDEx"
        @chat_number = "1"
        @msg_number = "1"

        delete '/applications/'+ @token + '/chats/' + @chat_number + '/messages/' + @msg_number

        expect(response).to have_http_status(:ok)
    end

    it 'Update message' do
        @token = "erEK5aaMrmjVHNpLUoH1HDEx"
        @chat_number = "1"
        @msg_number = "1"
        @msg_body="test body"

        put '/applications/'+ @token + '/chats/' + @chat_number + '/messages/' + @msg_number, params: {body:  @msg_body}, as: :json

        expect(response).to have_http_status(:ok)
    end

    it 'Search messages body' do
        @token = "UvfVTp5wT8G5rpG2NAUPXDVL"
        @chat_number = "1"
        @msg_number = "1"
        @search_body = "search"

        post '/applications/'+ @token + '/chats/' + @chat_number + '/messages', params: {search_body:  @search_body}, as: :json

        expect(response).to have_http_status(:ok)
    end
end