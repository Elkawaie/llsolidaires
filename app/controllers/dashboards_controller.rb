class DashboardsController < ApplicationController

  def owner
    @flats = Flat.all
    @own_flats = current_user.flats
    @own_rentals = current_user.rentals
  end

  def medical
     @flats = Flat.where("address ILIKE ?", "%#{params[:query]}%")
     if params[:query]
      @flats = Flat.near(params[:query], 20)

      @markers = @flats.map do |flat|
        {
          lat: flat.latitude,
          lng: flat.longitude,
          # infoWindow: { content: render_to_string(partial: "/flats/maps", locals: { flat: flat }) }
        }
      end
    else
      @flats = Flat.geocoded
    end
    # raise
  end

  def show
    set_flat
  end
private

  def set_flat
    @flat = Flat.find(params[:id])
  end

  def flat_params
    params.require(:flat).permit(:address, :flat_type, :description, :accessibility_pmr)
  end

end
