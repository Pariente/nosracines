class AddPrivacyToTables < ActiveRecord::Migration[6.0]
  def change
    add_column :documents, :private, :boolean, default: false
    add_column :people, :private, :boolean, default: false
  end
end
