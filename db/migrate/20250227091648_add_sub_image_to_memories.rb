class AddSubImageToMemories < ActiveRecord::Migration[8.0]
  def change
    add_column :memories, :sub_image, :string
  end
end
