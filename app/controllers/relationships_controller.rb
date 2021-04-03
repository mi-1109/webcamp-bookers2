class RelationshipsController < ApplicationController

  def create
    current_user.follow(params[:id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.unfollow(params[:id])
    redirect_back(fallback_location: root_path)
  end

  #————————フォロー・フォロワー一覧を表示する-————————————
  def followings
    @title = "Following"
    @user = User.find(params[:user_id])
    @users = @user.following_user
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:user_id])
    @users = @user.follower_user
    render 'show_follow'
  end

end
