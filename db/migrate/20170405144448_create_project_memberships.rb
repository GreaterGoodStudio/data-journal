class CreateProjectMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :project_memberships do |t|
      t.references :project, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :moderator, default: false

      t.timestamps
    end
  end
end
