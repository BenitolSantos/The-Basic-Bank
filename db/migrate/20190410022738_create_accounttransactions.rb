class CreateAccounttransactions < ActiveRecord::Migration
  def change
    create_table :accounttransactions do |t|
      t.integer :account_id
      t.integer :transaction_id #
    end
  end
end
