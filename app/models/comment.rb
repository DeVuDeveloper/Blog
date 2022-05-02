class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :update_comments_counter

  private

  def update_comments_counter
    @posts.each do |post|
      post.update_column(:comments_counter, post.comments.count) if post.id == post_id
    end
  end
end
