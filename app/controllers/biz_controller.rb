class BizController < ApplicationController
   def index
     @page_title = "Business Services"
   end

  def billboards_redirect
    redirect_to biz_billboards_path
  end
end
