class MakePhotosPolymorphic < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :photos, :sessions
    change_table :photos do |t|
      t.rename :session_id, :photographable_id
      t.string :photographable_type
    end
    add_index :photos, [:photographable_id, :photographable_type]
    remove_index :photos, :photographable_id

    change_table :data_points do |t|
      t.remove_references :photo
    end

    change_table :photos do |t|
      t.string :ancestry
    end
    add_index :photos, :ancestry

    reversible do |dir|
      Photo.reset_column_information
      Photo.update_all photographable_type: "Session"
    end
  end
end
