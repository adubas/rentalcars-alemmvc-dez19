class RentalBuilder
	attr_reader :params, :subsidiary, :token_generator

	def initialize(params, subsidiary, token_generator = TokenGenerator)
    @params = params
    @subsidiary = subsidiary
    @token_generator = token_generator
	end

	def build
		rental = Rental.new(params)
    rental.subsidiary = subsidiary
    rental.status = :scheduled
    rental.reservation_code = token_generator.generate
    rental
	end
end