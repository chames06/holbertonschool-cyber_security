#!/usr/bin/env ruby

require 'json'

# Reads a JSON file and counts occurrences of each userId
# @param path [String] path to JSON file
def count_user_ids(path)
  return unless File.exist?(path)

  data = JSON.parse(File.read(path))

  counts = {}

  data.each do |entry|
    user_id = entry['userId']
    next unless user_id

    counts[user_id] = 0 unless counts.key?(user_id)
    counts[user_id] += 1
  end

  counts.keys.sort.each do |id|
    puts "#{id}: #{counts[id]}"
  end
end
