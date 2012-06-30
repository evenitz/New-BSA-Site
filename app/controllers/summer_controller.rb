class SummerController < ApplicationController
  def index
    @page_title = "Summer Services"
  end

  def hours_redirect
    redirect_to summer_hours_path
  end
end
