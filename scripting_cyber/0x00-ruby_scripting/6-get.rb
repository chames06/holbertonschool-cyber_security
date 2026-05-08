#!/usr/bin/env ruby

require 'net/http'
require 'uri'
require 'json'

# Performs an HTTP GET request and prints status + body in JSON format
# @param url [String] target URL
def get_request(url)
  uri = URI.parse(url)

  response = Net::HTTP.get_response(uri)

  puts "Response status: #{response.code} #{response.message}"
  puts 'Response body:'

  begin
    json_body = JSON.parse(response.body)
    puts JSON.pretty_generate(json_body)
  rescue JSON::ParserError
    # If response is not JSON, print raw body
    puts response.body
  end
end
