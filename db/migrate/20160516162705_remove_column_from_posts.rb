class RemoveColumnFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :count
  end
end
