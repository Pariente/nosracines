class BookEvent < ApplicationRecord
  belongs_to :book
  belongs_to :event
end
