class User < ApplicationRecord
  has_secure_password

  # scope :first_user, -> {User.first}

  validates :name, presence: true, format: { with: /\A[a-zA-Z\s]+\z/ }

  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }

  validates :password,
            presence: true,
            format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,20}\z/, message: "must be at least 8 characters long and include atleast one number, one letter and one speacial character." }

  def all_unscoped_projects
    projects.unscoped.all
  end

  def self.first_user
    User.first
  end
end
