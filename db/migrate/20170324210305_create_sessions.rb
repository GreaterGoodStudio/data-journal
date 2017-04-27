class CreateSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :sessions do |t|
      t.string :name
      t.string :slug
      t.date :date
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true

      t.timestamps
    end

    add_index :sessions, :slug, unique: true
  end
end
