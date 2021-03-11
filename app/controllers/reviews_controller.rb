class ReviewsController < ApplicationController


  def create
    @review = Review.new(review_params)
    @yacht = Yacht.find(params[:yacht_id])
    @review.user = current_user
    @review.yacht = @yacht
    authorize @review
    if @review.save!
      redirect_to yacht_path(@yacht)
    else
      render :new
    end
  end

  def update
  end

  def destroy
    @review = Review.find(params[:id])
    authorize @review
    @review.destroy
    redirect_to yacht_path(@review.yacht)
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
