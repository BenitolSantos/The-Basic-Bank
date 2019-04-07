class Accounttransactions < ActiveRecord::Migration
  def change
    create_table :account_transactions do |t|
      t.integer :account_id
      t.integer :transaction_id
    end
  end
end
