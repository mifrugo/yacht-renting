class YachtsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show user_list]
  before_action :set_yacht, only: %i[show book review edit destroy]

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

  def user_list
    @yachts = Yacht.where(user_id: params[:id])
    @user = User.find_by_id(params[:id])

    authorize @yachts

    redirect_to root_path, notice: 'User not found 😢' unless @user
  end

  def create
    @yacht = Yacht.new(yacht_params)
    @yacht.user = current_user

    authorize @yacht

    if @yacht.save
      save_services if params[:yacht][:services]
      save_equipments if params[:yacht][:equipments]

      redirect_to yacht_path(@yacht), notice: "Listing succesfully created!"
    else
      render :new
    end
  end

  def edit
  end

  def destroy
    @yacht.destroy

    redirect_to yacht_user_path(@yacht.user_id), notice: 'Yacht removed'
  end

  private

  def set_yacht
    @yacht = Yacht.find(params[:id])
    authorize @yacht
  end

  def yacht_params
    params.require(:yacht).permit(
      :title, :description, :lat, :long, :price_per_day, :bed_space, { photos: [] }
    )
  end

  def save_services
    params[:yacht][:services].each do |service|
      new_service = Service.new(name: service)
      new_service.yacht = @yacht
      new_service.save
    end
  end

  def save_equipments
    params[:yacht][:equipments].each do |equipment|
      new_equipment = Equipment.new(name: equipment)
      new_equipment.yacht = @yacht
      new_equipment.save
    end
  end
end
