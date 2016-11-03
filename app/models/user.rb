class User < ActiveRecord::Base
  # write associations here
  has_many :rides
  has_many :attractions, :through => :rides
  has_secure_password
  after_initialize :set_default_role

  def mood
    if self.nausea > self.happiness
      "sad"
    else
      "happy"
    end
  end

  def set_default_role
    self.admin = false if self.admin.nil?
  end
end
