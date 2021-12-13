class HomeController < ApplicationController
    before_action :check_if_admin
    def index
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
