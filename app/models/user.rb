class User < ActiveRecord::Base
  # Relations
  has_many :tickets
  has_many :events, :through => :tickets
  has_many :entries
  
  # Validations
  validates_presence_of :email
  validates_presence_of :password
  validates_confirmation_of :password
  validates_presence_of :name
  validates_uniqueness_of :email
  
  # Methods
  def active?
    self.active == 1
  end
  
  def verified?
    self.verified == 1
  end
  
  def self.register(name, email, password, mobile = nil, id = nil)
    user = User.find_by_email(email)
    if user.blank?
      user = User.create({:name => name, :email => email, :password => password, :ref => "U#{User.newpass(8)}"})
    end
    user.update_attributes({:mobile => mobile}) if mobile 
    user.update_attributes({:id_number => id}) if id
    user
  end
  
  def self.newpass( len )
      chars = ("0".."9").to_a
      newp = ""
      1.upto(len) { |i| newp << chars[rand(chars.size-1)] }
      return newp
  end
end
