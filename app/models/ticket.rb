class Ticket < ActiveRecord::Base
  # Relations
  belongs_to :user
  belongs_to :event
  belongs_to :pass
  has_many :entries
  
  # Validations
  
  
  
  # Methods
  def expired?
    self.expires < Time.now
  end
  
  def used?
    # NOTE: FOR ENTRIES CALCULATED DAILY, A SCRIPT RUN AT MIDNIGHT WILL RESET COUNTERS
    self.entries_available == 0
  end
  
  # USed when the ticket is scanned
  def check!()
    # Check to see if the ticket is expired
    if self.expired?
      return { :success => false, :message => "Ticket Expired", :resultcode => 0, :date => Time.now.strftime("%Y-%m-%d"), :eventid => self.event_id  }
    # Check to see if the available entries have been exhausted
    elsif self.used?
      return { :success => false, :message => "No Entries Available", :resultcode => 0, :date => Time.now.strftime("%Y-%m-%d"), :eventid => self.event_id  }
    # Otherwise, grant access
    else
      # Decrement available entries
      self.update_attributes({:entries_used => self.entries_used + 1, :entries_available => self.entries_available - 1})
      # Log an entry under the ticket
      Entry.log(self)
      # Return success!
      return { :success => true, :message => "Access Granted", :resultcode => 1, :date => Time.now.strftime("%Y-%m-%d"), :eventid => self.event_id }
    end
  end
  
  # Used when a new pass is sold and a ticket is created
  def self.assign(pass, user, comments = nil)
    tix = Ticket.create({:pass => pass, :ref => "T#{Ticket.newpass(8)}", :event => pass.event, :user => user, :entries_available => pass.entries_allowed,
     :expires => pass.expires
     })
     tix.update_attributes({:comments => comments}) if comments
     pass.update_attributes({:used => pass.used + 1, :available => pass.available - 1})
     tix
  end
  
  def self.newpass( len )
      chars = ("0".."9").to_a
      newp = ""
      1.upto(len) { |i| newp << chars[rand(chars.size-1)] }
      return newp
  end
end
