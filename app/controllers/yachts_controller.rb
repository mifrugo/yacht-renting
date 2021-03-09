class YachtsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
  end

  def show
  end

  def book
  end

  def review
  end

  def create
    @yacht = Yacht.new(yacht_params)

    if @yacht.save
      redirect_to yacht_path(@yacht), notice: "Listing succesfully created!"
    else
      render :new
    end
  end

  def edit
  end

  def destroy
  end

  def new
    @yacht = Yacht.new
  end

  private

  def yacht_params
    params.require(:yacht).permit(:title, :description, :lat, :long, { photos: [] })
  end
end
