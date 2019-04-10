class Transactions < ActiveRecord::Base
  belongs_to :user
  has_many :account_transactions
  has_many :accounts, through: :account_transactions
end
