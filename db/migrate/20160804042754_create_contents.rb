class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :sentence

      t.timestamps null: false
    end
  end
end
