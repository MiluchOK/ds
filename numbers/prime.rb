require 'prime'
require 'rspec'

include RSpec::Matchers

def get_prime(number)
	return false if number == 1

	(2..number-1).each do |n|
		if number % n == 0
			return false
		end
	end
	return true
end

(1..99999).to_a.each do |n|
    expect(get_prime(n)).to eq (Prime.prime? n)
end