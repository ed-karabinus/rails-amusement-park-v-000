class User < ActiveRecord::Base
  # write associations here
  has_many :rides
  has_secure_password
end
