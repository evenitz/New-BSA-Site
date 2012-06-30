class InfoController < ApplicationController
  
  def index
    @page_title = "Info Channel"
  end

  def announcements_redirect
    redirect_to info_announcements_path
  end

end
