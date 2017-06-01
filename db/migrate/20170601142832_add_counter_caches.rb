class AddCounterCaches < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :sessions_count, :integer, default: 0

    add_column :sessions, :data_points_count, :integer, default: 0
    add_column :sessions, :consent_forms_count, :integer, default: 0

    reversible do |dir|
      dir.up do
        Project.find_each { |p| Project.reset_counters(p.id, :sessions) }
        Session.find_each { |p| Session.reset_counters(p.id, :data_points, :consent_forms) }
      end
    end
  end
end
