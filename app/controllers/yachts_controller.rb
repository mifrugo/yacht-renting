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
  end

  def new
    @yacht = Yacht.new
  end

  private

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
