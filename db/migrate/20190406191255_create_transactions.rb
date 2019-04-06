class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transaction do |t|
      t.integer :ammount
      t.integer :account_id_1
      t.integer :account_id_2
    end
  end
end
