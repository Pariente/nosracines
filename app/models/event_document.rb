class EventDocument < ApplicationRecord
  belongs_to :event
  belongs_to :document
end
