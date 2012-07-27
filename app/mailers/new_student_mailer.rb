class NewStudentMailer < ActionMailer::Base
  default from: "bsa@brown.edu"

  def send_welcome_email(user)
    @user = user
    mail(:to => user.email, :subject => "Welcome to Brown!")
  end
end
