class CreateDataPoints < ActiveRecord::Migration[5.0]
  def change
    create_table :data_points do |t|
      t.text :observation
      t.text :meaning
      t.references :session, foreign_key: true
      t.references :photo, foreign_key: true

      t.timestamps
    end
  end
end
