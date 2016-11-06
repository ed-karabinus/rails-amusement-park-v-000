class AttractionsController < ApplicationController
  def index
    @attractions = Attraction.all
    current_user
  end

  def show
    @attraction = Attraction.find_by(id: params[:id])
    current_user
  end

  def new
    @attraction = Attraction.new
  end

  def create
    @attraction = Attraction.new(attraction_params)
    if @attraction.save
      redirect_to attraction_path(@attraction)
    else
      redirect_to new_attraction_path
    end
  end

  def take_ride
    @attraction = Attraction.find_by(id: params[:id])
    if current_user.height >= @attraction.min_height && current_user.tickets >= @attraction.tickets 
      @ride = Ride.create(user_id: current_user.id, attraction_id: @attraction.id)
      current_user.tickets -= @attraction.tickets
      current_user.nausea += @attraction.nausea_rating
      current_user.happiness += @attraction.happiness_rating
      current_user.save
      flash[:success_notice] = "Thanks for riding the #{@attraction.name}!"
    end
    if current_user.height < @attraction.min_height
      flash[:height_alert] = "You are not tall enough to ride the #{@attraction.name}"
    end
    if current_user.tickets < @attraction.tickets
      flash[:ticket_alert] = "You do not have enough tickets to ride the #{@attraction.name}"
    end
    redirect_to user_path(current_user)
  end

  def edit
    @attraction = Attraction.find_by(id: params[:id])
  end

  def update
    @attraction = Attraction.find_by(id: params[:id])
    if @attraction.update(attraction_params)
      flash[:success_notice] = "You edited #{@attraction.name}"
      redirect_to attraction_path(@attraction)
    else
      redirect_to edit_attraction_path(@attraction)
    end
  end

  private

  def attraction_params
    params.require(:attraction).permit(:name, :nausea_rating, :min_height, :happiness_rating, :tickets)
  end
end
