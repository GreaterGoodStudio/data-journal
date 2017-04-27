class AddBookmarksToDataPoints < ActiveRecord::Migration[5.0]
  def change
    add_column :data_points, :bookmark_member, :boolean, default: false
    add_column :data_points, :bookmark_moderator, :boolean, default: false
  end
end
