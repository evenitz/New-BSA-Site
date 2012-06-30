class WebsiteResource < ActiveRecord::Base
  def self.get(id)
    WebsiteResource.find_by_element_id(id)
  end
end
