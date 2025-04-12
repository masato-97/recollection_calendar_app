class CreateMiddlePostTags < ActiveRecord::Migration[8.0]
  def change
    create_table :middle_post_tags do |t|
      t.references :post, foreign_key: true, null: false
      t.references :post_tag, foreign_key: true, null: false

      t.timestamps
    end
    add_index :middle_post_tags, [ :post_tag_id, :post_id ], unique: true
  end
end
