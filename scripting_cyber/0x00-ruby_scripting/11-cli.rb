#!/usr/bin/env ruby

require 'optparse'
require 'fileutils'

TASKS_FILE = 'tasks.txt'

# Ensure tasks file exists
def ensure_file
  FileUtils.touch(TASKS_FILE) unless File.exist?(TASKS_FILE)
end

# Add a task
def add_task(task)
  ensure_file
  File.open(TASKS_FILE, 'a') do |file|
    file.puts(task)
  end
  puts "Task '#{task}' added."
end

# List tasks
def list_tasks
  ensure_file
  tasks = File.readlines(TASKS_FILE, chomp: true)

  if tasks.empty?
    puts 'No tasks found.'
  else
    puts 'Task:'
    tasks.each do |task|
      puts "#{task}"
    end
  end
end

# Remove a task by index
def remove_task(index)
  ensure_file
  tasks = File.readlines(TASKS_FILE, chomp: true)

  if index < 1 || index > tasks.length
    puts 'Invalid index.'
    return
  end

  removed = tasks.delete_at(index - 1)

  File.open(TASKS_FILE, 'w') do |file|
    tasks.each { |task| file.puts(task) }
  end

  puts "Task '#{removed}' removed."
end

options = {}

parser = OptionParser.new do |opts|
  opts.banner = 'Usage: cli.rb [options]'

  opts.on('-a', '--add TASK', 'Add a new task') do |task|
    options[:add] = task
  end

  opts.on('-l', '--list', 'List all tasks') do
    options[:list] = true
  end

  opts.on('-r', '--remove INDEX', Integer, 'Remove a task by index') do |index|
    options[:remove] = index
  end

  opts.on('-h', '--help', 'Show help') do
    puts opts
    exit
  end
end

parser.parse!

if options[:add]
  add_task(options[:add])
elsif options[:list]
  list_tasks
elsif options[:remove]
  remove_task(options[:remove])
else
  puts parser
end
