class AddCategoryToAliases < ActiveRecord::Migration[6.0]
  def change
    add_column :aliases, :category, :string
  end
end
