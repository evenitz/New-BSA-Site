class TicketMailer < ActionMailer::Base
  default from: "bsa@brown.edu"

    def send_event_ticket(ticket, gen = true)
      unless gen == false
        res = `ruby /opt/sites/reach/vendor/ruby/1.9.1/gems/wkhtmltopdf-0.1.2/bin/wkhtmltopdf http://brownbsa.com/qr/ticket/#{ticket.ref} /opt/sites/reach/tmp/ticket_#{ticket.ref}.pdf`
        puts "ruby /opt/sites/reach/vendor/ruby/1.9.1/gems/wkhtmltopdf-0.1.2/bin/wkhtmltopdf http://brownbsa.com/qr/ticket/#{ticket.ref} /opt/sites/reach/tmp/ticket_#{ticket.ref}.pdf"
        while res.to_s.include? "Failed"
           res = `ruby /opt/sites/reach/vendor/ruby/1.9.1/gems/wkhtmltopdf-0.1.2/bin/wkhtmltopdf http://brownbsa.com/qr/ticket/#{ticket.ref} /opt/sites/reach/tmp/ticket_#{ticket.ref}.pdf`
        end
       end
       filename = "/opt/sites/reach/tmp/ticket_#{ticket.ref}.pdf"
      #filename = "/opt/sites/reach/tmp/cache/#{ticket.ref}-final.pdf"
      @ticket = ticket
      mail(
        :subject              => 'Your Ticket to ' + ticket.event.name, # Subject Line
        :to                   => ticket.user.email,
        :bcc => "marketplace@brown.edu",
        :from                 => 'bsa@brown.edu',
        :postmark_attachments => [File.open(filename)] # add in any other forms such as release forms etc
      )
    end
end
