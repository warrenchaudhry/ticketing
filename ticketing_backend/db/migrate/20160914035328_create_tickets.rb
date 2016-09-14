class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :reporter_id
      t.integer :assigned_to, null: true
      t.integer :assigned_by, null: true
      t.datetime :started_at
      t.datetime :resolved_at
      t.integer :priority, default: 0, null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end
    add_index :tickets, :title, type: :fulltext
    add_index :tickets, :description, type: :fulltext

    add_index :tickets, :status
  end
end
