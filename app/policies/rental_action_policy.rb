class RentalActionPolicy
  attr_reader :current_user, :rental

  def initialize(rental, current_user)
    @rental = rental
    @current_user = current_user 
  end

  def authorized?
    current_user.admin? || current_user.subsidiary == rental.subsidiary
  end
end