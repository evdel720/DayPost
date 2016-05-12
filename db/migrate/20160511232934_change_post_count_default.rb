class ChangePostCountDefault < ActiveRecord::Migration
  def change
    change_column_default(:posts, :count, 0)
  end
end
