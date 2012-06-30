class StaffMailer < ActionMailer::Base
  default from: "bsa@brown.edu"
  
  def send_welcome_letter(user)
    @user = user
    mail(:to => user[0], :subject => "Welcome to BSA Web Publishing!")
  end
end
