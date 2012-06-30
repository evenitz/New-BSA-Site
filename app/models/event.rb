class Event < ActiveRecord::Base
  # Relations
  has_many :entries
  has_many :passes
  has_many :tickets
  has_many :users, :through => :tickets
  
  # Validations
  validates_presence_of :name
  
  def self.newpass( len )
      chars = ("0".."9").to_a
      newp = ""
      1.upto(len) { |i| newp << chars[rand(chars.size-1)] }
      return newp
  end
end
