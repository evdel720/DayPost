class AddColumnToPost < ActiveRecord::Migration
  def change
    add_reference :posts, :comments, index: true, foreign_key: true
  end
end
