class CreateFavorites < ActiveRecord::Migration[8.0]
  def change
    create_table :favorites, if_not_exists: true do |t|
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end
    add_index :favorites, [ :user_id, :post_id ], unique: true
  end
end
