class AddDatesToProjectTask < ActiveRecord::Migration
  def change
     add_column :projects, :finished_at, :datetime
     add_column :projects, :archived_at, :datetime
  end
end
