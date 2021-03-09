class YachtsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_yacht, only: %i[show edit update delete]

  def index
    @yachts = policy_scope(Yacht)
  end

  def show
  end

  def new
    @yacht = Yacht.new
    authorize @yacht
  end

  def book
  end

  def review
  end

  def create
    @yacht = Yacht.new(yacht_params)
    @yacht.user = current_user
    authorize @yacht

    if @yacht.save
      redirect_to @yacht, notice: "Yacht was successfully created"
    else
      render :new
    end
  end

  def edit
  end

  def destroy
  end

  private

  def set_yacht
    @yacht = Yacht.find(params[:id])
    authorize @yacht
  end

  def yacht_params
    params.require(@yacht).permit(:title, :description, :booking_type)
  end
end
