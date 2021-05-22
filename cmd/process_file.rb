# frozen_string_literal: true

require_relative '../lib/line_parser'
require_relative '../lib/visits_counter'
require_relative '../lib/stats_sorter'

# @ProcessFile is a command that orchestrates reading the webserver log,
# parsing each line, and printing the sorted stats to STDOUT.
class ProcessFile
  def initialize(file_path)
    @file_path = file_path
    @counter = VisitsCounter.new
  end

  def call
    record_each_line
    print_top_total_views
    print_top_unique_views
  end

  private

  def print_top_total_views
    puts '--- TOP TOTAL VIEWS ---'
    StatsSorter.new(@counter.stats).by_total.each do |stat|
      puts "#{stat.path} #{stat.total}"
    end
    puts '--- END TOP TOTAL VIEWS ---'
  end

  def print_top_unique_views
    puts '--- TOP UNIQUE VIEWS ---'
    StatsSorter.new(@counter.stats).by_unique.each do |stat|
      puts "#{stat.path} #{stat.unique}"
    end
    puts '--- END TOP UNIQUE VIEWS ---'
  end

  def record_each_line
    File.foreach(@file_path) do |line|
      parsed_line = LineParser.new(line).call
      @counter.record(parsed_line)
    end
  end
end
