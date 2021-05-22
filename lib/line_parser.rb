# frozen_string_literal: true

require_relative './line'

# @LineParser accepts a string that is a single line in the webserver log
# and returns an instance of @Line.
# Supports the following line format: "$PATH $IP". If the input does not 
# follow the format, raises a @LineParser::UnexpectedLineFormatError
class LineParser
  UnexpectedLineFormatError = Class.new(StandardError)

  attr_reader :line

  def initialize(line)
    @line = line
  end

  def call
    sections = line.strip.split(' ')
    raise UnexpectedLineFormatError unless sections.size == 2

    Line.new(path: sections.first, ip: sections.last)
  end
end
