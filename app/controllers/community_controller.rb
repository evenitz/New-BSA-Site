class CommunityController < ApplicationController
  
  def index
    @page_title = "Community Affairs"
  end

  def inspire_redirect
    redirect_to community_inspire_path
  end
end
