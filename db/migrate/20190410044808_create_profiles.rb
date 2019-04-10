class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :content
      t.integer :balance
      t.integer :user_id
    end
  end
end
