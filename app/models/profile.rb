class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :profile_transactions
  has_many :transactions, through: :profile_transactions
end
