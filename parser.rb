#!/usr/bin/env ruby
# frozen_string_literal: true

require './cmd/process_file'

if ARGV.size != 1
  puts 'ERROR: please provide exactly one argument, the file path to the server log'
  exit(1)
end

file_path = ARGV.first
ProcessFile.new(file_path).call
