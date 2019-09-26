class FollowsController < ApplicationController
  before_action: :authenticate_user

  def create
    @follow = Follow.new(
      user_id: @current_user.id,
      author_id: params[:id])
    if  @follow.save
      flash[:notice] = "フォローしました。"
      redirect_to("/users/#{params[:id]}")
    end
  end

  def destroy
    @follow = Follow.find_by(author_id: params[:id])
    if @follow.destroy
      flash[:notice] = "フォローを解除しました。"
      redirect_to("/users/#{params[:id]}")
    end
  end


end
