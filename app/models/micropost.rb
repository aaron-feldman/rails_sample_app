class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  mount_uploader :picture, PictureUploader
  validates :content, presence: true
  validates :user_id, presence: true
  validate  :picture_size
  
  # Returns microposts from the users being followed by the given user.
  def Micropost.from_users_followed_by(user)
    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: user)
  end
  
  # Returns microposts about a user.
  def Micropost.about_a_user(user)
    #return Micropost.where("about_id = ?", user[:id]) # Alternative form
    posts = Micropost.find_by_sql ["SELECT * FROM microposts WHERE about_id = ?", user[:id]]
    return posts
   end

  private

    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end