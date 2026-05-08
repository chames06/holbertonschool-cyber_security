#!/usr/bin/env ruby

require 'digest'

# Performs a dictionary attack against a SHA-256 hash
def crack_password(target_hash, dictionary_file)
  return unless File.exist?(dictionary_file)

  File.foreach(dictionary_file) do |word|
    candidate = word.strip
    hash = Digest::SHA256.hexdigest(candidate)

    if hash == target_hash
      puts "Password found: #{candidate}"
      return
    end
  end

  puts 'Password not found in dictionary.'
end

# CLI handling
if ARGV.length != 2
  puts 'Usage: 10-password_cracked.rb HASHED_PASSWORD DICTIONARY_FILE'
  exit
end

hashed_password = ARGV[0]
dictionary_file = ARGV[1]

crack_password(hashed_password, dictionary_file)
