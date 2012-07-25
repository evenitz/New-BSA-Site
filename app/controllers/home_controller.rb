class HomeController < ApplicationController
  def work
    render :layout => false
  end
  def index
    render :layout => false
    #@page_title = WebsiteResource.get('page-title-home').content
  end
 
  def test_dev
    render :text => "HELLO WORLD"
  end
  
  def reset
   system "touch /opt/sites/reach/tmp/restart.txt"
   render :text => "Restarting... <script type='text/javascript'>setTimeout(\"document.location.href='/'\", 5000);</script>"
 end
end
