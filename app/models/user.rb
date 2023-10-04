class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :tenant
  accepts_nested_attributes_for :tenant

  def with_tenant
    build_tenant if tenant.nil?
    self
  end
end
