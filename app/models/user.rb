class User < ActiveRecord::Base
  has_many :transactions
  has_secure_password #includes validation for password
  validates_presence_of :username,:email
  #removed password_digest because  has_secure_password
  #model file should be lowercase

  def slug
    self.username.downcase
  end

  def self.find_by_slug(slug)
    @all_user_info = []
    self.all.each do |user|
      if user.slug == slug
        @all_user_info << user
      end
    end
    @all_user_info[0]
  end
end
