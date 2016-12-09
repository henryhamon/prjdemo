class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.boolean :active

      t.timestamps null: false
    end
  end
end
