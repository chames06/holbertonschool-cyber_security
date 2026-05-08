#!/usr/bin/env ruby

require 'prime'

# Function that checks if a number is prime
# @param number [Integer] number to check
# @return [Boolean] true if prime, false otherwise
def prime(number)
  return false unless number.is_a?(Integer)
  return false if number < 2

  Prime.prime?(number)
end
