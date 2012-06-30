class Entry < ActiveRecord::Base
  # Relations
  belongs_to :ticket
  belongs_to :event
  belongs_to :user
  
  # Methods
  def self.log(ticket)
    Entry.create({:ticket => ticket, :event => ticket.event, :user => ticket.user})
  end
  
  def self.newpass( len )
      chars = ("0".."9").to_a
      newp = ""
      1.upto(len) { |i| newp << chars[rand(chars.size-1)] }
      return newp
  end
end
