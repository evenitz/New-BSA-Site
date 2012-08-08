class CommentsController < ApplicationController
  
  def send_email
    if params[:email][:name] and params[:email][:email_address] and params[:email][:content]
      FeedbackMailer.comment_email(params[:email]).deliver
    end
    redirect_to root_path
    
  end
end
