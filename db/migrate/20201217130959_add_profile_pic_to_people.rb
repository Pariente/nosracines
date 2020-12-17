class AddProfilePicToPeople < ActiveRecord::Migration[6.0]
  def change
    add_column :people, :profile_pic, :string
  end
end
