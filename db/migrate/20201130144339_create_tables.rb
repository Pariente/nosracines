class CreateTables < ActiveRecord::Migration[6.0]
  def change
    create_table :funds do |t|
      t.string :name

      t.timestamps null: false
    end

    create_table :documents do |t|
      t.string :name
      t.date :date
      t.string :reference
      t.string :location
      t.integer :privacy, default: 0

      t.references :fund, index: true, foreign_key: true
      t.timestamps null: false
    end

    create_table :files do |t|
      t.string :url
      t.text :transcript
      t.text :translation_fr
      t.string :language
      t.text :comment
      t.text :persons_position
      t.string :original_format
      t.string :color

      t.references :document, index: true, foreign_key: true
      t.timestamps null: false
    end

    create_table :people do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :nee
      t.date :birth_date
      t.date :death_date

      t.timestamps null: false
    end

    create_table :documents_people do |t|
      t.references :document, index: true, foreign_key: true
      t.references :person, index: true, foreign_key: true
      t.timestamps null: false
    end

    create_table :aliases do |t|
      t.string :name

      t.references :person, index: true, foreign_key: true
      t.timestamps null: false
    end

    create_table :sources do |t|
      t.string :name

      t.timestamps null: false
    end

    create_table :documents_sources do |t|
      t.references :document, index: true, foreign_key: true
      t.references :source, index: true, foreign_key: true
      t.timestamps null: false
    end

  end
end
