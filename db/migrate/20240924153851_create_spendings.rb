class CreateSpendings < ActiveRecord::Migration[7.2]
  def change
    create_table :spendings do |t|
      t.date :date
      t.decimal :value
      t.references :employee, foreign_key: true
      t.references :department, foreign_key: true

      t.timestamps
    end
  end
end
