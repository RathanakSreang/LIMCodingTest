class CreatePageContents < ActiveRecord::Migration
  def change
    create_table :page_contents do |t|
      t.integer :page_id
      t.integer :content_id
      t.timestamps null: false
    end
    add_index :page_contents, [:page_id, :content_id], unique: true
  end
end
