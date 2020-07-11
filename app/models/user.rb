class User < ApplicationRecord
    before_save { self.email = email.downcase }#alt = { email.downcase! }
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: true
    # makes sure there is passwords and password confirmation with hash
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
end
