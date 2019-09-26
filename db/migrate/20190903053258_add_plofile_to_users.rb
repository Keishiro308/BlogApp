class AddPlofileToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users,:prifile,:text
  end
end
