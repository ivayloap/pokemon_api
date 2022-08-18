class CreateSlots < ActiveRecord::Migration[7.0]
  def change
    create_table :slots do |t|
      t.references :pokemon, null: false, index: true
      t.references :type, null: false, index: true
      t.string :external_id

      t.timestamps
    end
  end
end
