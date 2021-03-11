class YachtsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show user_list]
  before_action :set_yacht, only: %i[show book review edit destroy favorite]
  before_action :set_selections, only: %i[new edit create]

  def index
    @yachts = policy_scope(Yacht)
  end

  def show
    @user = User.find(@yacht.user_id)
    @favorite = current_user.favorites.find { |f| f.yacht_id == @yacht.id } || nil
    @review = Review.new
  end

  def new
    @yacht = Yacht.new

    authorize @yacht
  end

  def book
  end

  def review
  end

  def user_favorite
    @yachts = current_user.favorite_yachts
    authorize @yachts
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
      @services_selected = params[:yacht][:services] || []
      @equipments_selected = params[:yacht][:equipments] || []

      render :new
    end
  end

  def edit
    @services_selected = @yacht.service_types.map(&:id)
    @equipments_selected = @yacht.equipment_types.map(&:id)
  end

  def destroy
    @yacht.destroy

    redirect_to yacht_user_path(@yacht.user_id), notice: 'Yacht removed'
  end

  private

  def set_selections
    @services = ServiceType.all
    @equipments = EquipmentType.all

    @services_selected = @equipments_selected = []
  end

  def set_yacht
    @yacht = Yacht.find(params[:id])
    authorize @yacht
  end

  def yacht_params
    params.require(:yacht).permit(
      :title, :description, :lat, :long, :price_per_day, :bed_space, :address, { photos: [] }
    )
  end

  def save_services
    params[:yacht][:services].each do |service|
      new_service = Service.new(service_type_id: service)
      new_service.yacht = @yacht
      new_service.save
    end
  end

  def save_equipments
    params[:yacht][:equipments].each do |equipment|
      new_equipment = Equipment.new(equipment_type_id: equipment)
      new_equipment.yacht = @yacht
      new_equipment.save
    end
  end
end
