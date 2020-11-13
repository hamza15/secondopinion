class User < ActiveRecord::Base

    validates :first_name, :last_name, :email, :password, presence: true
    validates_uniqueness_of :email
    has_secure_password
    has_many :reviews
    has_many :doctors, through: :reviews
end
