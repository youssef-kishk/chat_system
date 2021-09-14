class ChatsController < ApplicationController
    before_action :get_app
    before_action :get_chat, only: [:show, :destroy]

    # GET /applications/[app_token]/chats
    def index
        chats = Chat.where(application_id: @app.id)
        render json: chats, :except => [:id, :application_id],status: :ok
    end

    # GET /applications/[app_token]/chats/number
    def show
        render json: @chat, :except => [:id, :application_id],status: :ok
    end

    # POST /applications/[app_token]/chats
    def create
        max_number = Chat.where(application_id: @app.id).maximum("number")
        if !max_number.present?
            max_number = 0
        end
        max_number +=1
        HandleChatWorker.perform_async(max_number, @app.id)
        render json: {Number:max_number},status: :created    
    end

    # DELETE /applications/[app_token]/chats/number
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
