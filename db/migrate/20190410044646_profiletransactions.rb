class Profiletransactions < ActiveRecord::Migration
  def change
    create_table :profiletransactions do |t|
      t.integer :profile_id
      t.integer :transaction_id
    end
  end
end
