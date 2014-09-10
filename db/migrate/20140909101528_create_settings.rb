class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings, {id:false} do |t|
      t.string :key
      t.string :value

      t.timestamps
    end
  end
end
