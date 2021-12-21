class User < ApplicationRecord
    has_secure_password
    has_many :recipes
    validates :username, presence: true
    validates :username, uniqueness: true
    # validates_confirmation_of :password
    scope :find_user_by_id, (id) ->{where("id = ?", id )}

end
