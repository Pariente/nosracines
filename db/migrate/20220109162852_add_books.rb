class AddBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :cover
      t.string :author
      t.string :publisher
      t.string :isbn
      t.boolean :privacy, default: false
      t.date :date_publication
      t.text :summary
      t.text :notes

      t.timestamps null: false
    end

    create_table :books_people do |t|
      t.references :book, index: true, foreign_key: true
      t.references :person, index: true, foreign_key: true
      t.timestamps null: false
    end

    create_table :books_documents do |t|
      t.references :book, index: true, foreign_key: true
      t.references :document, index: true, foreign_key: true
      t.timestamps null: false
    end

    create_table :books_events do |t|
      t.references :book, index: true, foreign_key: true
      t.references :event, index: true, foreign_key: true
      t.timestamps null: false
    end

    create_table :books_locations do |t|
      t.references :book, index: true, foreign_key: true
      t.references :location, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
