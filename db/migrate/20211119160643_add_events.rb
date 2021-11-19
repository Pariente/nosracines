class AddEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :name
      t.date :date_start
      t.date :date_end
      t.text :story
      t.text :comment
      t.string :illustration

      t.timestamps null: false
    end

    create_table :events_people do |t|
      t.references :event, index: true, foreign_key: true
      t.references :person, index: true, foreign_key: true
      t.timestamps null: false
    end

    create_table :events_documents do |t|
      t.references :event, index: true, foreign_key: true
      t.references :document, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
