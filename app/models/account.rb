class Account
  belongs_to :user
  has_many :account_transactions
  has_many :transactions, through: :account_transactions
end
