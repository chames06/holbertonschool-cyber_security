#!/usr/bin/env ruby
require 'net/http'
require 'uri'
require 'json'

# Performs an HTTP POST request and prints status + body
# @param url [String] target URL
# @param body_params [Hash] parameters to send in body
def post_request(url, body_params)
    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme == 'https'

    request = Net::HTTP::Post.new(uri.path, {
        'Content-Type' => 'application/json'
    })
    request.body = body_params.to_json

    response = http.request(request)

    puts "Response status: #{response.code} #{response.message}"
    puts "Response body:"
    parsed_body = JSON.parse(response.body)
    if parsed_body.empty?
        puts "{}"
    else
        puts JSON.pretty_generate(parsed_body)
    end
end
