class RelationshipsController < ApplicationController

  def follow
    current_user.follow(params[:id])
    redirect_back(fallback_location: root_path)
  end

  def unfollow
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

  # def followings
  #   relationship = Relationship.where("followed_id = ?",params[:user_id])
  #   @users = User.where("user_id = ?", relationship.follower_id)
  #   @title = 'Followings Users'
  # end

  # def followers
  #   @user_id = Relationship.find_by(follower_id:params[:user_id]).followed_id
  #   @title = 'Followers Users'

  #   render action: 'followings'
  # end
end
