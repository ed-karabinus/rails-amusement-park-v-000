class AttractionsController < ApplicationController
  def index
    @attractions = Attraction.all
  end

  def show
    @attraction = Attraction.find_by(id: params[:id])
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
end
