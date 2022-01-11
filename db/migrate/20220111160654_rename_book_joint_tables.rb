class RenameBookJointTables < ActiveRecord::Migration[6.0]
  def change
    rename_table :books_documents, :book_documents
    rename_table :books_events, :book_events
    rename_table :books_locations, :book_locations
    rename_table :books_people, :book_peopl
  end
end