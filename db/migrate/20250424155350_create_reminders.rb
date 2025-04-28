class CreateReminders < ActiveRecord::Migration[8.0]
  def change
    create_table :reminders do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :mail_receiving_saturday, default: false, null: false
      t.boolean :mail_receiving_sunday, default: false, null: false

      t.timestamps
    end
  end
end
