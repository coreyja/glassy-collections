class AddPhotoProcessingToPhoto < ActiveRecord::Migration[4.2]
  def change
    add_column :photos, :photo_processing, :boolean
  end
end
