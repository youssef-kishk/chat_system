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
        chat = Chat.new(number: max_number+1, application_id: @app.id)
        if chat.save
            render json: {Number:chat.number},status: :created
        else
            render json: {status: 'ERROR', message: 'Chat not created', data:chat.errors},status: :unprocessable_entity
        end     
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
