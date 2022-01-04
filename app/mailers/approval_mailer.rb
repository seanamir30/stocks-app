class ApprovalMailer < ApplicationMailer
    default from: 'ascsstocks@gmail.com'
  
    def welcome_email
      @user = params[:user]
      mail(to: @user.email, subject: 'Notice of Approval')
    end
end