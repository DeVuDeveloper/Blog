class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end

after_save :update_posts_counter

private

def update_posts_counter
  @users.each do |user|
    user.update_column(:posts_counter, user.posts.count) if user.id == author_id
  end
end
