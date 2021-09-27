class ApplicationsController < ApplicationController
    before_action :get_app, only: [:show, :destroy, :update]

    # GET /applications
    def index
        all_apps = Application.order('created_at ASC')
        render json: all_apps, :except => [:id],status: :ok
    end

    # GET /applications/[token]
    def show
        render json: @app, :except => [:id],status: :ok
    end    

    # POST /applications { "name": '' }
    def create
        app = Application.new(app_params)
        if app.save
            render json: {Token:app.token},status: :created
        else
            render json: {status: 'ERROR', message: 'Application not created', data:app.errors},status: :unprocessable_entity
        end
    end

    # DELETE /applications/[token]
    def destroy
        begin
            @app.destroy
            render json: @app, :except => [:id],status: :ok   
        rescue Exception
            render json: {status: 'ERROR', message: 'Application delete failed'},status: :bad_request
        end
    end

    # PUT /applications/[token] { "name": '' }
    def update
        if @app.update_attributes(app_params)
            render json: @app, :except => [:id],status: :ok
        else
            render json: {status: 'ERROR', message: 'Application update failed', data:@app.errors},status: :unprocessable_entity
        end
    end

    
    private
    def app_params
        params.permit(:name)
    end

    def get_app
        @app = Application.find_by(token: params[:id])
        if !@app.present?
            render json: {status: 'ERROR', message: 'Application not found'},status: :not_found
        end
    end  
end
