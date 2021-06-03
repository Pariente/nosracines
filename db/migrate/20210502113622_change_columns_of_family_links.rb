class ChangeColumnsOfFamilyLinks < ActiveRecord::Migration[6.0]
  def change
    rename_column :family_links, :character_id, :person_a_id
    rename_column :family_links, :linked_character_id, :person_b_id
    rename_column :family_links, :link_1_to_2, :link_a_to_b
    rename_column :family_links, :link_2_to_1, :link_b_to_a
  end
end