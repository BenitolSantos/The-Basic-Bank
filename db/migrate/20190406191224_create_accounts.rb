class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :content
      t.integer :user_id
    end
  end
end
