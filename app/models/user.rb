class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy

  #いいね機能
  has_many :favorites, dependent: :destroy

  belongs_to :book, optional: true


  validates :name,length: { in: 2..20 }
  validates :introduction, length: { maximum: 50}

  #カラム(profile_image_id)を追加
  attachment :profile_image
end
