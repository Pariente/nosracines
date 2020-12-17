class Person < ActiveRecord::Base
  has_many :documents_people
  has_many :aliases
end
