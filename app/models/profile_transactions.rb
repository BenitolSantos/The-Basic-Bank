class AccountTransactions < ActiveRecord::Base
 belongs_to :profile
 belongs_to :transactions
end
