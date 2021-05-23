# frozen_string_literal: true

require_relative '../lib/line_parser'
require_relative '../lib/visits_counter'
require_relative '../lib/stdout_presenter'

# @ProcessFile is a command that orchestrates reading the webserver log,
# parsing each line, and printing the sorted stats to STDOUT.
class ProcessFile
  def initialize(file_path)
    @file_path = file_path
    @counter = VisitsCounter.new
  end

  def call
    record_each_line
    @presenter = StdoutPresenter.new(counter.stats)
    print_top_total_views
    print_top_unique_views
  end

  private

  attr_reader :counter, :presenter, :file_path

  def print_top_total_views
    puts '--- TOP TOTAL VIEWS ---'
    puts presenter.total
    puts '--- END TOP TOTAL VIEWS ---'
  end

  def print_top_unique_views
    puts '--- TOP UNIQUE VIEWS ---'
    puts presenter.unique
    puts '--- END TOP UNIQUE VIEWS ---'
  end

  def record_each_line
    File.foreach(file_path) do |line|
      parsed_line = LineParser.new(line).call
      @counter.record(parsed_line)
    end
  end
end
