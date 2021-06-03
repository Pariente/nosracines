class FamilyLink < ApplicationRecord
  belongs_to :a_person, class_name: "Person", foreign_key: "person_a_id"
  belongs_to :b_person, class_name: "Person", foreign_key: "person_b_id"
end