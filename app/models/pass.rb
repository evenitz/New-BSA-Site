class Pass < ActiveRecord::Base
  # NOTE: FOR ENTRIES CALCULATED DAILY, A SCRIPT RUN AT MIDNIGHT WILL RESET COUNTERS
  
  # Relations
  belongs_to :event
  
  # Validations
  
  
  # MEthods
  def calculate_entries_daily?
    self.calculate_entries_daily == 1
  end
end
