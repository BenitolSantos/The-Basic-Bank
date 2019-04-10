class AccountTransactions < ActiveRecord::Base
 belongs_to :account
 belongs_to :transactions
end
