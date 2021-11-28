class LocationDocument < ApplicationRecord
  belongs_to :location
  belongs_to :document
end
