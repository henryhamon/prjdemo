class AddClientToProject < ActiveRecord::Migration
  def change
    add_column :projects, :client, :string
    add_index :projects, :client
  end
end
