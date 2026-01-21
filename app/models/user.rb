class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true

  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }

  validates :password,
            format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,20}\z/, message: "must be at least 8 characters long and include atleast one number, one letter and one speacial character." }
end
