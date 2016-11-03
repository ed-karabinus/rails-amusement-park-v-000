class Ride < ActiveRecord::Base
  # write associations here
  belongs_to :attraction
  belongs_to :user

  def take_ride
    error = 'Sorry.'
    insufficient_tickets = self.user.tickets < self.attraction.tickets
    insufficient_height = self.user.height < self.attraction.min_height
    if insufficient_tickets
      error += " You do not have enough tickets to ride the #{self.attraction.name}."
    end
    if insufficient_height
      error += " You are not tall enough to ride the #{self.attraction.name}."
    end
    unless error == 'Sorry.'
      return error
    else
      self.user.tickets -= self.attraction.tickets
      self.user.nausea += self.attraction.nausea_rating
      self.user.happiness += self.attraction.happiness_rating
      self.user.save
    end
  end
end
