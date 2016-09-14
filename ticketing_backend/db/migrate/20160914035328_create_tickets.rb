class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :status, null: false
      t.integer :reporter_id, index: true, null: false
      t.integer :assigned_to
      t.integer :assigned_by
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
