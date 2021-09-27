require 'rails_helper'

describe 'Applications APIs:', type: :request do

    it 'Return all applications' do
        get '/applications'

        expect(response).to have_http_status(:ok)
    end

    it 'Return application by token' do
        @token = "a8pYohCSZQLCWodmHcwi7eXM"

        get '/applications/'+ @token

        expect(response).to have_http_status(:ok)
    end

    it 'Create application' do
        @app_name = "test1"

        post '/applications', params: {name:  @app_name}, as: :json

        expect(response).to have_http_status(:created)
    end

    it 'Delete application' do
        @token = "oveaC7x8FMkpEVK8pysRkPaj"

        delete '/applications/' + @token

        expect(response).to have_http_status(:ok)
    end

    it 'Update application' do
        @token = "erEK5aaMrmjVHNpLUoH1HDEx"
        @app_name = "test2"

        put '/applications/' + @token, params: {name:  @app_name}, as: :json

        expect(response).to have_http_status(:ok)
    end
end