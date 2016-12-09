class AddDatesToNotes < ActiveRecord::Migration
  def change
     add_column :notes, :finished_at, :datetime
     add_column :notes, :archived_at, :datetime
  end
end
