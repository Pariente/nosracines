class AddPrivacyToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :privacy, :boolean, default: false
  end
end
