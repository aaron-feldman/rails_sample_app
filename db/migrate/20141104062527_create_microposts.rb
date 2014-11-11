class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.text :content
      t.references :user, index: true
      #t.references :by, index: true
      t.references :about, index: true
      t.boolean :published
      
      t.timestamps null: false
    end
    add_index :microposts, [:user_id, :created_at]
  end
end