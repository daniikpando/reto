class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :products
  has_many :comments
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  def update_permission_level
     self.update(permittion_level: 1)
  end
  def update_your_count(c)
      self.update(account_of_saving: c)
  end
  include PermissionOfUser
end
