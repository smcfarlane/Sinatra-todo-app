class Todo < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :text
      t.boolean :done
      t.date :due_date
      t.references :list

      t.timestamps
    end
  end
end
