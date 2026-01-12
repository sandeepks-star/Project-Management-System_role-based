class User < ApplicationRecord

	has_secure_password

	validates :name, presence: true
	validates :email, presence: true, uniqueness: true, on: :create
	validates :password, length: {minimum: 6}
end
