class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_one_attached :profile_image
         validates :name,uniqueness: true,length: {in: 2..20}
         validates :introduction,length: {maximum: 50}
         has_many :books,dependent: :destroy
         has_many :book_comments,dependent: :destroy
         has_many :favorites,dependent: :destroy

         has_many :relationships,foreign_key: "following_id"
         has_many :reverse_of_relationships,class_name: "Relationship",foreign_key: "follower_id"
         has_many :followings,through: :relationships,source: :follower
         has_many :followers,through: :reverse_of_relationships,source: :following

         def get_profile_image(width,height)
           if profile_image.attached?
             profile_image.variant(resize_to_limit: [width,height]).processed
           else
             "no_image"
           end
         end

         def favorited_by?(user)
              favorites.exists?(user_id: user.id)
         end

         def follow(user_id)
              relationships.create(follower_id: user_id)
         end

         def unfollow(user_id)
              relationships.find_by(follower_id: user_id).destroy
         end

         def following?(user)
              followings.include?(user)
         end

        

end
