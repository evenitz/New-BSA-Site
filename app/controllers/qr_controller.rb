class QrController < ApplicationController
  layout 'application', :only => [:dsp]
  layout 'tabs', :only => [:entry_list]
  
  def hello
    render :text => "HELLO"
  end
  
  def events
    @events = Event.find(:all, :conditions => ["starts < ? and ends > ? and active = 1 and sponsor = ?", 3.days.from_now, Time.now, params[:p]])
  end
  
  def sms_check
    @ticket = Ticket.find_by_ref(params["Body"].to_s)
    res = @ticket.check!
    render :text => '<?xml version="1.0" encoding="UTF-8" ?><Response><Sms>' + res[:message].to_s + '</Sms></Response>'
    logger.info  '<?xml version="1.0" encoding="UTF-8" ?><Response><Sms>' + res[:message].to_s + '</Sms></Response>'
  end
  
  def check
    @ticket = Ticket.find_by_ref(params[:id])
    eventid = ((params[:ev]) ? params[:ev].to_i : 0)
    logger.info request.env["HTTP_USER_AGENT"].to_s
    if @ticket.blank?
      result = { :success => false, :message => "No Entries Available", :resultcode => -1, :date => Time.now.strftime("%Y-%m-%d"), :eventid => eventid }
    #elsif not request.env["HTTP_USER_AGENT"].to_s.include? "Squid%20Scanner"
      #result = { :success => false, :message => "Unauthorized Scanning Device", :resultcode => -1, :date => Time.now.strftime("%Y-%m-%d"), :eventid => eventid }
   # elsif (not params[:o] or params[:o].upcase != @ticket.sponsor) and (5 != 5)
    #   result = { :success => false, :message => "Unauthorized User", :resultcode => -1, :date => Time.now.strftime("%Y-%m-%d"), :eventid => eventid }
    elsif Digest::SHA256.hexdigest(params[:id] + params[:e] + "LINGKEANDMIKE4EVER")[-10..-1] != params[:s]
      result = { :success => false, :message => "TICKET TAMPERED WITH!!!", :resultcode => -1, :date => Time.now.strftime("%Y-%m-%d"), :eventid => @ticket.event_id }
    else
      logger.info @ticket.event_id.to_i
      logger.info eventid.to_i
      if @ticket.event_id.to_i != eventid.to_i
        result = { :success => false, :message => "Ticket is for Different Event", :resultcode => -1, :date => Time.now.strftime("%Y-%m-%d"), :eventid => @ticket.event_id }
      else
        result = @ticket.check!
      end
    end
    logger.info result.inspect
    render :text => "<user><eventid>#{result[:eventid]}</eventid><date>#{result[:date]}</date><resultcode>#{result[:resultcode]}</resultcode><message>#{result[:message]}</message></user>"
  end
  
  def entry_list
    @page_title = "Scanned Tickets"
    @event = Event.find_by_sponsor_and_ref(params[:sponsor], params[:ref])
    @entries = @event.entries.order("created_at DESC") unless @event.blank?
  end
  
  def all_tickets
     u = User.find_by_ref(params[:id])
     @tickets = Ticket.find_all_by_user_id(u.id).select { |x| x.pass_id == 7 or x.pass_id == 8 }
     urls = @tickets.map { |x| ("http://brownbsa.com/q/" + x.ref.to_s + "/#{x.event_id.to_s}?s=#{Digest::SHA256.hexdigest(x.ref + x.event_id.to_s + "LINGKEANDMIKE4EVER")[-10..-1]}") }
     @qrs = urls.map { |u| "https://chart.googleapis.com/chart?chs=500x500&cht=qr&chl=#{u}&choe=UTF-8" }
     body = (0..(urls.size - 1)).map { |q| "<div style='padding:20px;width:500px;margin-left:auto;margin-right:auto;position:relative;' algn='center'><img src='/_media/images/ticketing/ticket_logo_#{@tickets[q].event_id}' width='500px' height='250px' style='position:relative;z-index:1;' /><img src='#{@qrs[q]}' style='position:relative;margin-top:0px;z-index:2;' /><img src='/_media/images/ticketing/info_pass_#{@tickets[q].pass_id}.jpg' width='500px' height='118px' /><p style='text-align:center;font-family:Helvetica;font-size:100%;margin-bottom:-10px;'>#{@tickets[q].ref}</p>" + ((@tickets[q].comments.to_s.size > 5) ? "<p style='text-align:center;font-family:Helvetica;font-size:100%'>#{@tickets[q].comments.to_s}</p>" : "") + "</div><div style='page-break-after: always'>&nbsp;</div>" }
     render :text => "<html><body>#{body.join("")}</body></html>"
   end

   def ticket
     @ticket = Ticket.find_by_ref(params[:id])
     url = ("http://brownbsa.com/q/" + @ticket.ref.to_s + "/#{@ticket.event_id.to_s}?s=#{Digest::SHA256.hexdigest(@ticket.ref + @ticket.event_id.to_s + "LINGKEANDMIKE4EVER")[-10..-1]}")
     @qr = "https://chart.googleapis.com/chart?chs=500x500&cht=qr&chl=#{url}&choe=UTF-8"
     render :text => "<html><body><div style='padding:20px;width:500px;margin-left:auto;margin-right:auto;position:relative;' algn='center'><img src='/_media/images/ticketing/ticket_logo_#{@ticket.event_id}' width='500px' height='250px' style='position:relative;z-index:1;' /><img src='#{@qr}' style='position:relative;margin-top:0px;z-index:2;' /><img src='/_media/images/ticketing/info_pass_#{@ticket.pass_id}' width='500px' height='118px' /><p style='text-align:center;font-family:Helvetica;font-size:100%;margin-bottom:-10px;'>#{@ticket.ref}</p>" + ((@ticket.comments.to_s.size > 5) ? "<p style='text-align:center;font-family:Helvetica;font-size:100%'>#{@ticket.comments.to_s}</p>" : "") + "</div></body></html>"
   end

   def ticket_pdf
       kit = PDFKit.new("http://brownbsa.com/qr/ticket/#{params[:id]}")
       filename = "#{RAILS_ROOT}/tmp/ticket_#{params[:id]}.pdf"
       kit.to_file(filename) # inline PDF
       send_file filename, :type => "application/pdf"
   end

   def all_ticket_pdf
       kit = PDFKit.new("http://brownbsa.com/qr/all_tickets/?uid_secret_345=#{params[:id]}")
       filename = "#{RAILS_ROOT}/tmp/tickets_#{params[:id]}.pdf"
       kit.to_file(filename) # inline PDF
       send_file filename, :type => "application/pdf"
   end
  
  def tix
    u = User.find_by_ref(params[:id])
    unless u.blank?
      logger.info `ruby /opt/sites/reach/vendor/ruby/1.9.1/gems/wkhtmltopdf-0.1.2/bin/wkhtmltopdf http://brownbsa.com/qr/all_tickets/?uid_secret_345=#{u.id} /opt/sites/reach/tmp/tickets_#{u.ref}.pdf`
     sleep(2)
     filename = "/opt/sites/reach/tmp/tickets_#{params[:id]}.pdf"
     send_file filename, :type => "application/pdf"
    else
      render :text => "INVALID LINK"
    end
  end
  
  # Email Parsing Stuffs
  def parse
    File.open("/opt/sites/reach/mail/#{params['MessageID']}", "w+") { |w| w.puts "Subject: #{params['Subject']}\nBody:\n#{params['TextBody']}" }
    body = params['TextBody']
    if body.include? "5583033" or body.include? "1488116"
      name = "#{body.split("First Name:")[1].split("\n")[0]} #{body.split("Last Name:")[1].split("\n")[0]}"
      email = body.split("Email Address:")[1].split("\n")[0].gsub(" ", "")
      mobile = body.split("Phone Number")[1].split("\n")[0].gsub(" (XXX-XXX-XXXX): ", "")
      u = User.register(name, email, "auto-fulfill", mobile)
      if body.include? "5583033"
         pass_id = 8
         tix = Ticket.assign(Pass.find(pass_id), u)
         tix.update_attributes({:mailed => -2})
      end
      if body.include? "1488116"
        pass_id = 7
        tix = Ticket.assign(Pass.find(pass_id), u)
        tix.update_attributes({:mailed => -2})
      end
    #  begin
     #   TicketMailer.send_event_ticket(tix).deliver
     # rescue Exception => e
     #   logger.info e.inspect
     # else
     #   tix.update_attributes({:mailed => 1})
     # end
    elsif body.include? "6168485"
      name = "#{body.split("First Name:")[1].split("\n")[0]} #{body.split("Last Name:")[1].split("\n")[0]}"
      email = body.split("Email Address:")[1].split("\n")[0].gsub(" ", "")
      mobile = body.split("Phone Number")[1].split("\n")[0].gsub(" (XXX-XXX-XXXX): ", "")
      amt =  body.split("Subtotal")[1].split("\n")[0].gsub(" ", "")
      qty = body.split("Quantity: ")[1].split(/[^0-9\.]/)[0].gsub(" ", "")
      affiliation = body.split("Affiliation: ")[1].split("\n")[0]
      order_text = body.split("Bread")[1].split("Affiliation")[0].to_s.split("\n").collect { |x| x.split(": ")[1].to_s }
      data = [Time.zone.now.strftime("%m/%d"), name, email, mobile, affiliation, amt, qty]
      order_text.each { |d| data << d unless d == "" }
      logger.info data
      File.open("/opt/sites/reach/marketshares.txt", "w+") { |x| x.puts "#{data.join("|")}" }
    end
    render :text => "info received"
  end
  
end
