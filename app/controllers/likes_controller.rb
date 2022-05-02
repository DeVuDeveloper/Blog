class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.new(author_id: current_user.id, post_id: @post.id)

    if @like.save
      flash[:notice] = 'Like created succsefully.'
      redirect_to user_posts_path(@post.author_id, @post.id)
    else
      flash[:alert] = 'Liking failed.'
      render :_like, status: :unprocessable_entity
    end
  end
end
