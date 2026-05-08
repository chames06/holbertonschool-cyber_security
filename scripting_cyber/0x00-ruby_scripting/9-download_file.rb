#!/usr/bin/env ruby

require 'open-uri'
require 'uri'
require 'fileutils'

# Downloads a file from a URL and saves it locally
def download_file(url, path)
  uri = URI.parse(url)

  puts "Downloading file from #{url}..."

  data = URI.open(uri).read

  directory = File.dirname(path)
  FileUtils.mkdir_p(directory) unless Dir.exist?(directory)

  File.open(path, 'wb') do |file|
    file.write(data)
  end

  puts "File downloaded and saved to #{path}."
end

# CLI handling
if ARGV.length != 2
  puts 'Usage: 9-download_file.rb URL LOCAL_FILE_PATH'
  exit
end

download_file(ARGV[0], ARGV[1])
