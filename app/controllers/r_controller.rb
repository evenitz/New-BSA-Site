class RController < ApplicationController
  def index
    ln = Redirect.find_by_url(params[:id])
    redirect_to ln.redirect
  end
end
