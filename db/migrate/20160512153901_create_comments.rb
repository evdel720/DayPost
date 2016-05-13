class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :count, default: 0
      t.references :author, index: true
      t.references :post, index:true, foreign_key: true

      t.timestamps null: false
    end

    add_foreign_key :comments, :users, column: :author_id
  end
end
