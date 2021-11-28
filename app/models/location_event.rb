class LocationEvent < ApplicationRecord
  belongs_to :location
  belongs_to :event
end
