class CommentsController < ApplicationController

  def create
    comment = Comment.create(comments_params)
    redirect_to "/prototypes/#{comment.prototype.id}"
  end

  private

  def comments_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
