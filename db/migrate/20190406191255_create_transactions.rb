class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transaction do |t|
      t.integer :ammount
    end
  end
end
