class AddAvatarToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :avatar, :string
    add_column :photos, :user_id, :integer
  end
end
