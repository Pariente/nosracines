class RenameTablesEvents < ActiveRecord::Migration[6.0]
  def change
    rename_table :events_documents, :event_documents
    rename_table :events_people, :event_people
  end
end
