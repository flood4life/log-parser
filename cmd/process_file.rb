# frozen_string_literal: true

require_relative '../lib/line_parser'
require_relative '../lib/visits_counter'
require_relative '../lib/stdout_presenter'

# @ProcessFile is a command that orchestrates reading the webserver log,
# parsing each line, and returning a string suitable for printing.
class ProcessFile
  def initialize(file_path)
    @file_path = file_path
    @counter = VisitsCounter.new
  end

  def call
    record_each_line
    @presenter = StdoutPresenter.new(counter.stats)
    result = ''
    result += top_total_views
    result += top_unique_views

    result
  end

  private

  attr_reader :counter, :presenter, :file_path

  def top_total_views
    <<~TOTAL
      --- TOP TOTAL VIEWS ---
      #{presenter.total}
      --- END TOP TOTAL VIEWS ---
    TOTAL
  end

  def top_unique_views
    <<~UNIQUE
      --- TOP UNIQUE VIEWS ---
      #{presenter.unique}
      --- END TOP UNIQUE VIEWS ---
    UNIQUE
  end

  def record_each_line
    File.foreach(file_path) do |line|
      parsed_line = LineParser.new(line).call
      @counter.record(parsed_line)
    rescue LineParser::UnexpectedLineFormatError
      # do nothing, log warning
    end
  end
end
