class Transactions < ActiveRecord::Base
  belongs_to :user
  has_many :profile_transactions
  has_many :profiles, through: :profile_transactions
end
