class Book < ApplicationRecord

    
    belongs_to :user

    has_many :users

    has_many :favorites, dependent: :destroy
    def favorited_by?(user)
        favorites.where(user_id: user.id).exists?
    end

    validates :title, length: { minimum: 1 }
    validates :body, length: { in: 1..200 }
    
end
