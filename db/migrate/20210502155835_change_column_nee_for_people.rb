class ChangeColumnNeeForPeople < ActiveRecord::Migration[6.0]
  def change
    rename_column :people, :nee, :spouse_name
  end
end
