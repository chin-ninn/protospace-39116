class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_prototype, only: [:show, :edit]
  before_action :move_to_index, except: [:index, :show, :new]

  def index
    @prototypes = Prototype.all
  end

  def new
    unless user_signed_in?
      redirect_to action: :index
    end

    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.create(prototype_params)

    if @prototype.save
      redirect_to action: :index
    else
      render action: :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    
  end

  def update
    prototype = Prototype.find(params[:id])
    prototype.update(prototype_params)

    if prototype.save
      redirect_to action: :show
    else
      render action: :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to action: :index
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def move_to_index
    unless user_signed_in? && current_user.id == @prototype.user_id
      redirect_to action: :index
    end
  end
end
