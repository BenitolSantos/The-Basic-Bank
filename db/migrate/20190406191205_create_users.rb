class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :content
      t.float :balance
      t.string :password_digest #
    end
  end
end

#rake db:drop to clear database
