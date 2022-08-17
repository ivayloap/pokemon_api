class CreateSlots < ActiveRecord::Migration[7.0]
  def change
    create_table :slots do |t|
      t.integer :pokemon_id
      t.integer :type_id
      t.string :external_id

      t.timestamps
    end
  end
end
