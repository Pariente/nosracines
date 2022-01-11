class BookDocument < ApplicationRecord
  belongs_to :book
  belongs_to :document
end
