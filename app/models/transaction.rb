class Transaction
  belongs_to :user
  has_many :account_transactions
  has_many :accounts, through: :account_transactions
end
