class CreateUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :content
      t.integer :balance
      t.string :password_digest #
    end
  end
end

#rake db:drop to clear database
#sqlite3 doesn't accept floats so amount begins in cents
