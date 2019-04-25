class CreateTransactions < ActiveRecord::Migration[4.2]
  def change
    create_table :transactions do |t|
      t.float :amount
      t.string :version
      t.integer :user_id
    end
  end
end
