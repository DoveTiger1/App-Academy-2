class UserMailer < ApplicationMailer
    default from: 'everybody@appacademy.io'

    def welcome_email(user)
        @user = user
        mail(to: user.user_name, subject: 'Welcome to 99Cats!')
    end
end
