class AccountExchanges < ActiveRecord::Base
 belongs_to :account
 belongs_to :exchange
end
