class CreateConsentForms < ActiveRecord::Migration[5.0]
  def change
    create_table :consent_forms do |t|
      t.string :name
      t.json :images
      t.references :session, foreign_key: true

      t.timestamps
    end
  end
end
