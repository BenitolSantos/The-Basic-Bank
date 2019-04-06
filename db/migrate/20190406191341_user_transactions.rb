class UserTransactions < ActiveRecord::Migration
  def change
    create_table :usertransactions do |t|
      t.integer :user_id
      t.integer :transaction_id
    end
  end
end
