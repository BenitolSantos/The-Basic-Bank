class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :ammount
      t.integer :user_id
    end
  end
end
