class User < ActiveRecord::Base
  has_many :reviews 
  has_secure_password

  validates :email, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :password, length: { in: 6..20 }, on: :create     
  #validte password comes from bcrypt, the database field is actually password_digest

  def full_name
    "#{firstname} #{lastname}"
  end
  
end
