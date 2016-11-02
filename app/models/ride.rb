class Ride < ActiveRecord::Base
  # write associations here
  belongs_to :attraction
  belongs_to :user

  def take_ride
    error = 'Sorry.';
    if self.user.tickets < self.attraction.tickets
      error += " You do not have enough tickets to ride the #{self.attraction.name}."
    elsif self.user.height < self.attraction.min_height
      error += " You are not tall enough to ride the #{self.attraction.name}."
    end
    return error
  end
end
