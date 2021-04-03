class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  #フォローする側のUserから見て、フォローされる側のUserを(中間テーブルを介して)集める。なので親はfollower_id(フォローする側)。follower_idにuser_idを格納。
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  #フォローされる側のUserから見て、フォローしてくる側のUserを(中間テーブルを介して)集める。なので親はfollowed_id(フォローされる側)followed_idにuser_idを格納。
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  # =================== @user.followingsとした際に「@userがフォローしているUser一覧」を返すための記述 ===============================
  # ===================自分がフォローしているユーザと、自分をフォローしているユーザをthroughを使った関連付けで取得する===============
  #自分がフォローしているユーザ
  has_many :following_user, through: :follower, source: :followed
  #自分をフォローしているユーザ
  has_many :follower_user, through: :followed, source: :follower


  # =================== フォローする・フォロー外す・フォローしているか確認を行うメソッド ===========================================
  #ユーザをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  #ユーザのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  #フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end

  attachment :profile_image

  validates :name, uniqueness: true
  validates :name, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50}
end
