class Exchange < ActiveRecord::Base
  belongs_to :user
  has_many :account_exchanges
  has_many :accounts, through: :account_exchanges
end
