class AddLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :illustration
      t.string :address
      t.string :city
      t.string :region
      t.string :country
      t.string :latitude
      t.string :longitude
      t.boolean :privacy, default: false

      t.timestamps null: false
    end

    create_table :location_people do |t|
      t.references :location, index: true, foreign_key: true
      t.references :person, index: true, foreign_key: true
      t.timestamps null: false
    end

    create_table :location_documents do |t|
      t.references :location, index: true, foreign_key: true
      t.references :document, index: true, foreign_key: true
      t.timestamps null: false
    end

     create_table :location_events do |t|
      t.references :location, index: true, foreign_key: true
      t.references :event, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
