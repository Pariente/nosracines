class AdminInterface < ActiveRecord::Migration[6.0]
  def change
    add_column :documents, :box, :string
    add_column :documents, :notes, :text
    add_column :document_files, :name, :string
    add_column :people, :biography, :text
    add_column :people, :gender, :string
    add_column :people, :birth_place, :string
    add_column :people, :death_place, :string
    add_column :people, :notes, :text

    create_table :family_links do |t|
      t.integer :character_id
      t.integer :linked_character_id
      t.string :link_1_to_2
      t.string :link_2_to_1
      t.timestamps null: false
    end
  end
end
