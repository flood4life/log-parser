# frozen_string_literal: true

require_relative './line'

# @LineParser accepts a string that is a single line in the webserver log
# and returns an instance of @Line
class LineParser
  attr_reader :line

  def initialize(line)
    @line = line
  end

  def call
    sections = line.strip.split(' ')
    Line.new(path: sections.first, ip: sections.last)
  end
end
