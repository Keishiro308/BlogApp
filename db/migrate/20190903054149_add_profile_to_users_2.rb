class AddProfileToUsers2 < ActiveRecord::Migration[6.0]
  def change
    remove_column :users,:prifile,:text
    add_column :users,:profile,:text
  end
end
