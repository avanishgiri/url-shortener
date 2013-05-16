class User < ActiveRecord::Base
  has_many :urls
  validates :name, uniqueness: true


  def check_password(password)
    self.password == password
  end
end
