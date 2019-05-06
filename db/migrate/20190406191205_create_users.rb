class CreateUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :content
      t.integer :balance
      t.string :password_digest #bcrypt is working with activerecord and salting and encrypt password
      #.authenticate takes encrypts the params to compare
    end
  end
end

#rake db:drop to clear database
#sqlite3 doesn't accept floats so amount begins in cents
