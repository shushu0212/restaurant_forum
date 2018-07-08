class FriendshipsController < ApplicationController
  def create
    @friendship = Friendship.new(user: current_user, friending_id: params[:friending_id])

    if @friendship.save
      flash[:notice] = "Successfully friended"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = @friendship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    # where 會回傳物件集合(Array)
    friendships = Friendship.where(user: current_user, friending_id: params[:id])
    friendships.destroy_all
    flash[:alert] = "Friendship destroyed"
    redirect_back(fallback_location: root_path)
  end

end
