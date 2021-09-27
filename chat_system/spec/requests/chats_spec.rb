require 'rails_helper'

describe 'Chats APIs:', type: :request do

    it 'Return all application chats' do
        @token = "a8pYohCSZQLCWodmHcwi7eXM"

        get '/applications/' + @token + '/chats'

        expect(response).to have_http_status(:ok)
    end

    it 'Return application chat by number' do
        @token = "UvfVTp5wT8G5rpG2NAUPXDVL"
        @number = "1"

        get '/applications/'+ @token + '/chats/' + @number

        expect(response).to have_http_status(:ok)
    end

    it 'Create chat' do
        @token = "erEK5aaMrmjVHNpLUoH1HDEx"

        post '/applications/'+ @token + '/chats'

        expect(response).to have_http_status(:created)
    end

    it 'Delete chat' do
        @token = "erEK5aaMrmjVHNpLUoH1HDEx"
        @number = "1"

        delete '/applications/'+ @token + '/chats/' + @number

        expect(response).to have_http_status(:ok)
    end
end