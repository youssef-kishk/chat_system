class MessagesController < ApplicationController
    before_action :get_app
    before_action :get_chat
    before_action :get_msg, only: [:show, :destroy, :update]

    # GET /applications/[token]/chats/[number]/messages
    def index
        msgs = Message.where(chat_id: @chat.id)
        render json: msgs, :except => [:id, :chat_id],status: :ok
    end

    # GET /applications/[token]/chats/[number]/messages/[number]
    def show
        render json: @msg, :except => [:id, :chat_id],status: :ok
    end

    # POST /applications/[token]/chats/[number]/messages { "body": '' }
    def create
        max_number = Redis.current.get("#{@app.token}_#{@chat.id}").to_i
        if !max_number.present?
            max_number = 0
            Redis.current.set("#{@app.token}_#{@chat.id}", 1)
        else
            Redis.current.incr("#{@app.token}_#{@chat.id}")
        end
        max_number +=1
        HandleMessageWorker.perform_async(max_number,@chat.id,msg_params["body"])
        @chat.update_attribute(:msgs_count , @chat.msgs_count+1)
        render json: {Number:max_number},status: :created    
    end

    # DELETE /applications/[token]/chats/[number]/messages/[number]
    def destroy
        @msg.destroy
        render json: @msg, :except => [:id, :chat_id],status: :ok
    end

    # PUT /applications/[token]/chats/[number]/messages/[number] { "body": '' }
    def update
        if @msg.update_attributes(msg_params)
            render json: @msg, :except => [:id, :chat_id],status: :ok
        else
            render json: {status: 'ERROR', message: 'Message update failed', data:@msg.errors},status: :unprocessable_entity
        end
    end

    # POST /applications/[token]/chats/[number]/messages/search { "search_body": '' }
    def search
        search_result = Message.search_msg(@chat.id, msg_params[:search_body])
        render json: search_result, :except => [:id, :chat_id], status: :ok
    end


    private
    def msg_params
        params.permit(:body,:search_body)
    end

    def get_app
        @app = Application.find_by(token: params[:application_id])
        if !@app.present?
            render json: {status: 'ERROR', message: 'Application not found'},status: :not_found
        end
    end

    def get_chat
        @chat = Chat.where(application_id: @app.id, number: params[:chat_id]).first
        if !@chat.present?
            render json: {status: 'ERROR', message: 'Chat not found'},status: :not_found
        end
    end

    def get_msg
        @msg = Message.where(chat_id: @chat.id, number: params[:id]).first
        if !@msg.present?
            render json: {status: 'ERROR', message: 'Message not found'},status: :not_found
        end
    end
end
