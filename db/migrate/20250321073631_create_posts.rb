class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.references :user, foreign_key: true
      t.references :memory, foreign_key: true

      t.timestamps
    end

    add_index :posts, [ :user_id, :memory_id ], unique: true
  end
end
