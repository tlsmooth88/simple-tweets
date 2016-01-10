class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: {with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :simpletweets
  
  has_many :following_relations, class_name: "Relation", foreign_key: "follower_id", dependent: :destroy
  has_many :following_users, through: :following_relations, source: :followed
  
  has_many :follower_relations, class_name: "Relation", foreign_key: "followed_id", dependent: :destroy
  has_many :follower_users, through: :follower_relations, source: :follower
  
  def follow(other_user)
    following_relations.find_or_create_by(followed_id: other_user.id)
  end
  
  def unfollow(other_user)
    following_relation = following_relations.find_by(followed_id: other_user.id)
    following_relation.destroy if following_relation
  end
  
  def following?(other_user)
    following_users.include?(other_user)
  end
end
