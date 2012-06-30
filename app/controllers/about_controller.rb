class AboutController < ApplicationController
  def index
    @page_title = "About BSA"
  end

  def history_redirect
    redirect_to about_history_path
  end
end
