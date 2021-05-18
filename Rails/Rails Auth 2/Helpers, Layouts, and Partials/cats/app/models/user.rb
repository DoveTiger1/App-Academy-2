class User < ApplicationRecord
    validates :user_name, :session_token, presence: true
    validates :user_name, uniqueness: true
    validates :password_digest, presence: {message: 'password can\'t be blank'}
    validates :password, length: {minimum: 6, allow_nil: true}

    attr_reader :password

    after_initialize :ensure_session_token

    def self.generate_session_token
        SecureRandom::urlsafe_base64(16)
    end

    def self.find_by_credentials(username, password)
        user = User.find_by(user_name: username)

        return nil if user.nil?

        user.is_password?(password) ? user : nil
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def password=(newpassword)
        @password = newpassword
        self.password_digest = BCrypt::Password.create(@password)
    end

    def reset_session_token!
        self.session_token = self.class.generate_session_token
        self.save!
        self.session_token
    end

    def ensure_session_token
        self.session_token ||= self.class.generate_session_token
    end

    has_many(
        :cats,
        class_name: 'Cat',
        foreign_key: :user_id,
        primary_key: :id,
        dependent: :destroy
    )

    has_many(
        :requests,
        class_name: 'CatRentalRequest',
        foreign_key: :user_id,
        primary_key: :id,
        dependent: :destroy
    )
end