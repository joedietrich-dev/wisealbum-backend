class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable,
  :jwt_authenticatable, jwt_revocation_strategy: self

  attribute :role_id, default: 2
  
  belongs_to :organization, optional: true
  belongs_to :role

  def super_admin?
    self.role_id == 1
  end

  def org_owner?
    self.role_id == 2
  end

  def contributor?
    self.role_id == 3
  end

  def viewer?
    self.role_id == 4
  end
end
