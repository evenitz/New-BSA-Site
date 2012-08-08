class FeedbackMailer < ActionMailer::Base
  default from: "bsa@brown.edu"

  def comment_email(email_params)
    @email = email_params[:email_address]
    @name = email_params[:name]
    @comment = email_params[:content]
    mail(:to => "bsa@brown.edu", :subject => "BSA User Feedback")
  end
end
