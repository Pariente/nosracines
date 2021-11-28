class AddZipcodeToLocations < ActiveRecord::Migration[6.0]
  def change
    add_column :locations, :zipcode, :string
  end
end
