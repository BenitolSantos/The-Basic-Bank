class Account_Transaction < ActiveRecord::Base
  belongs_to :account
  belongs_to :transaction
end
