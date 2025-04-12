class CreateMiddleTags < ActiveRecord::Migration[8.0]
  def change
    create_table :middle_tags do |t|
      t.references :memory, foreign_key: true, null: false
      t.references :tag, foreign_key: true, null: false

      t.timestamps
    end
    add_index :middle_tags, [:tag_id, :memory_id], unique: true
  end
end
