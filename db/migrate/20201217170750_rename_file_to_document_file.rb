class RenameFileToDocumentFile < ActiveRecord::Migration[6.0]
  def change
    rename_table :files, :document_files
    rename_table :documents_sources, :document_sources
    rename_table :documents_people, :document_people
  end
end
