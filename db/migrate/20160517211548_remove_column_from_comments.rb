class RemoveColumnFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :count, :integer
  end
end
