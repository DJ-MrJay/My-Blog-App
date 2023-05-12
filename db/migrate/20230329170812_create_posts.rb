class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :author, null: false, foreign_key: { to_table: :users, column: :author_id }
      t.string :title
      t.text :text
      t.integer :comments_counter, default: 0
      t.integer :likes_counter, default: 0

      t.timestamps
    end
  end
end