class AddMainImageToMemories < ActiveRecord::Migration[8.0]
  def change
    add_column :memories, :main_image, :string
  end
end
