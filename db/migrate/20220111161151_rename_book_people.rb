class RenameBookPeople < ActiveRecord::Migration[6.0]
  def change
    rename_table :book_peopl, :book_people
  end
end
