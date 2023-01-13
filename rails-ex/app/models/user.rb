class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_secure_password validations: false

  # validates :name, presence: true, length: { in: 8..20 }, allow_blank: false
  validates :password, presence: true, length: { in: 8..20 }, allow_blank: false

  has_many :user_action
end
