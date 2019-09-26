class CommentsController < ApplicationController
  before_action: :authenticate_user



  def create
    @comment = Comment.new(
      post_id: params[:post_id],
      user_id: params[:user_id],
      content: params[:content]
    )
    if @comment.save
      flash[:notice]="コメントできました。"
      redirect_to("/posts/#{params[:post_id]}")
    else
      flash[:notice]="コメントできませんでした。"
      redirect_to("/posts/#{params[:post_id]}")
    end
  end
end
