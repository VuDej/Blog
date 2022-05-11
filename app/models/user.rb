class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable, :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :comments, foreign_key: 'author_id', dependent: :destroy
  has_many :likes, foreign_key: 'author_id', dependent: :destroy

  validates :name, presence: true
  validates_numericality_of :post_counter, allow_nil: true, greater_than_or_equal_to: 0

  def admin?
    role == 'admin'
  end

  def most_recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  def all_posts
    posts.order(created_at: :desc)
  end
end
