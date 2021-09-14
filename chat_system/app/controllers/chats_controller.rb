class ChatsController < ApplicationController
    before_action :get_app
    before_action :get_chat, only: [:show, :destroy]

    # GET /applications/[token]/chats
    def index
        chats = Chat.where(application_id: @app.id)
        render json: chats, :except => [:id, :application_id],status: :ok
    end

    # GET /applications/[token]/chats/number
    def show
        render json: @chat, :except => [:id, :application_id],status: :ok
    end

    # POST /applications/[token]/chats
    def create
        max_number = Redis.current.get(@app.token).to_i
        if !max_number.present?
            max_number = 0
            Redis.current.set(@app.token, 1)
        else
            Redis.current.incr(@app.token)
        end
        max_number +=1
        HandleChatWorker.perform_async(max_number, @app.id)
        @app.update_attribute(:chats_count , @app.chats_count+1)
        render json: {Number:max_number},status: :created    
    end

    # DELETE /applications/[token]/chats/number
    def destroy
        @chat.destroy
        render json: @chat, :except => [:id, :application_id],status: :ok
    end


    private
    def get_app
        @app = Application.find_by(token: params[:application_id])
        if !@app.present?
            render json: {status: 'ERROR', message: 'Application not found'},status: :not_found
        end
    end

    def get_chat
        @chat = Chat.where(application_id: @app.id, number: params[:id]).first
        if !@chat.present?
            render json: {status: 'ERROR', message: 'Chat not found'},status: :not_found
        end
    end
end
