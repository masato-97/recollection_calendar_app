class CreateMemories < ActiveRecord::Migration[8.0]
  def change
    create_table :memories do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.datetime :start_time
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
