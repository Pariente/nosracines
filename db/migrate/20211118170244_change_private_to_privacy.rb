class ChangePrivateToPrivacy < ActiveRecord::Migration[6.0]
  def change
    remove_column :documents, :privacy
    rename_column(:documents, :private, :privacy)
    rename_column(:people, :private, :privacy)
  end
end
