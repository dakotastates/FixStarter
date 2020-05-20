class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:omniauthable, :omniauth_providers => [:facebook]

    has_many :problems, dependent: :destroy
    has_many :proposals, dependent: :destroy
    has_many :votes, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :proposal_comments, dependent: :destroy
    #has_many :problems, through: :comments, dependent: :destroy
    #has_many :proposals, through: :proposal_comments, dependent: :destroy

    def self.from_omniauth(auth)
   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
   user.email = auth.info.email
   user.password = Devise.friendly_token[0,20]
      end
    end



    def username
      return self.email.split('@')[0].capitalize
    end
end
