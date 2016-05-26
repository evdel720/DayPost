class RemoveColumnFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :count, :integer
  end
end
