class CommentsController < ApplicationController

  def create
    @comment = Comment.create(comments_params)

    if @comment.save
      redirect_to "/prototypes/#{@comment.prototype.id}"
    else
      render "/prototypes/#{@comment.prototype.id}"
    end
  end

  private

  def comments_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
