class AdminController < ApplicationController
    # Checks if user is admin
    before_action :is_admin

    def index
        @users = User.where(admin: false, is_approved: true)
        @unapproved_users = User.where(is_approved: false, admin: false)
    end

    def approve
        respond_to do |format|
            @user = User.find(params[:id]).update(is_approved:true)
            ApprovalMailer.with(user: User.find(params[:id])).welcome_email.deliver_now
            format.html{redirect_to admin_index_path}
        end
    end

    def new
        @user = User.new
    end


    def create
        @user = User.new(user_params)
        @user.skip_confirmation!
            if @user.save
                redirect_to admin_index_path
                flash[:notice] = "User was successfully created."
            else
                render :new
            end
    end

    def show
        @user = User.find(params[:id])
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        respond_to do |format|
            if @user.update(user_params)
              format.html { redirect_to admin_path(params[:id]), notice: "User profile was successfully updated" }
            else
              format.html { render :edit, status: :unprocessable_entity }
            end
        end
    end

    private
        def user_params
            params.require(:user).permit(:email, :password, :first_name, :last_name, :balance)
        end

        def is_admin
            if authenticate_user! && current_user.admin
                return true
            else
                redirect_to root_path
            end
        end
        
end
