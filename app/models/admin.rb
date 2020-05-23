class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :registerable, :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :recoverable, :rememberable, :validatable
          # :omniauthable, omniauth_providers: [:admin_google]
  
  has_many :services
  has_many :slots,  through: :services
  has_many :events, through: :services

  def self.from_omniauth(access_token)
    data = access_token.info
    admin = Admin.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
    # unless user
    #     user = User.create(name: data['name'],
    #        email: data['email'],
    #        password: Devise.friendly_token[0,20]
    #     )
    # end
    admin
  end
end
