class GroupsController < ApplicationController
  
  def index
    @page_title = "Resources for Student Groups"
  end

  def billboards_redirect
    redirect_to groups_billboards_path
  end
end
