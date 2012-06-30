class MikeyController < ApplicationController
    layout 'tabs', :only => [:lingkepoo, :connieshrimp]
    
    def lingkepoo
      @page_title = "Scanned Tickets"
      if request.post?
        @users = User.find(:all, :conditions => ["email LIKE ?", "%#{params[:email]}%"])
      end
    end
    
    def connieshrimp
      @tickets = User.find_by_ref(params[:id]).tickets
    end
    
    def update
      t = Ticket.find_by_ref(params[:id])
      t.update_attributes({:pass_id => params[:pass_id], :event_id => Pass.find(params[:pass_id]).event_id, :mailed => params[:mailed], :entries_available => params[:entries_available]})
      redirect_to "/mikey/connieshrimp/#{t.user.ref}"
    end
    
    def new
      t = Ticket.assign(Pass.find(params[:pass_id]), User.find_by_ref(params[:id]))
      t.update_attributes({:mailed => params[:mailed].to_i})
      redirect_to "/mikey/connieshrimp/#{t.user.ref}"
    end
    
    def create_user
      if request.post?
        u = User.register(params[:name], params[:email], "create-user")
        redirect_to "/mikey/connieshrimp/#{u.ref}"
      end
    end
end
