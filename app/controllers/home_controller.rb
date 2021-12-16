class HomeController < ApplicationController
    before_action :check_if_admin
    def index
        if current_user

            @current_user = current_user
        end
    end


    def cash_in
        @user = current_user
        @user.balance += params[:amount].to_i
        @user.save
        redirect_to root_path
    end

    private
        def check_if_admin
            if current_user
                if current_user.admin?
                    redirect_to admin_index_path
                end
            end
        end
end
