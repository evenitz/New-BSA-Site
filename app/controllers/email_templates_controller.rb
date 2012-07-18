class EmailTemplatesController < ApplicationController
  def email_one
    render :layout => false
  end

  def email_two
    render :layout => false
  end
end
