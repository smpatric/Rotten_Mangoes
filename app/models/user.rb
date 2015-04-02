class User < ActiveRecord::Base
  has_many :reviews
  has_secure_password
  validates :email, :firstname, :lastname, presence: true
  validates :password, length: { in: 6..20 }, on: :create
  paginates_per 2

  def full_name
    "#{firstname} #{lastname}"
  end
end
