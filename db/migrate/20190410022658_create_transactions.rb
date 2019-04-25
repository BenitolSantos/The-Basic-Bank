class CreateTransactions < ActiveRecord::Migration[4.2]
  def change
    create_table :transactions do |t|
      t.integer :amount
      t.string :version
      t.integer :user_id
    end
  end
end

#sqlite3 doesn't accept floats so amount begins in cents
