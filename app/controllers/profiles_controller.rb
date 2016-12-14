class ProfilesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user_id, only: [:improve,:saving, :update]
    before_action :set_current_user, only: [:index]
    def index
    end
    def improve
        authenticate_security do
            if current_user == @user
                @user.update_permission_level
                respond_to do |format|
                    format.html { redirect_to root_url, notice: "Ya tiene permiso para vender"}
                end
            else
                render :index
            end
        end
    end
    def saving
    end

    def update
        authenticate_security do
            @user.update(update_account_of_saving)
            redirect_to root_url
        end
    end
    private
    def authenticate_security(&block)
        if current_user == @user
            block.call
        else
            respond_to do |format|
              format.html{redirect_to root_url , notice: "No tienes permiso"}
              #format.json { render json: @ }
            end
        end
    end
    def set_current_user
        @user = current_user
    end
    def update_account_of_saving
        params.require(:user).permit(:account_of_saving)
    end
    def set_user_id
        @user = User.find(params[:id])
    end
end
