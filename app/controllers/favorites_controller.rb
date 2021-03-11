class FavoritesController < ApplicationController
  before_action :single_yacht, only: :add
  before_action :single_favorite, only: :destroy

  def add
    favorite = Favorite.new(user: current_user, yacht: @yacht)
    favorite.save

    authorize favorite

    notice = favorite ? 'Added to favorite!' : 'Error in adding to favorite'

    redirect_back fallback_location: users_favorite_path, notice: notice
  end

  def destroy
    authorize @favorite

    @favorite.destroy

    redirect_back fallback_location: users_favorite_path, notice: 'Removed from favorites'
  end

  private

  def single_yacht
    @yacht = Yacht.find(params[:id])
  end

  def single_favorite
    @favorite = Favorite.find(params[:id])
  end
end
