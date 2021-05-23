# frozen_string_literal: true

require 'minitest/autorun'

require_relative '../lib/line_parser'

class TestLineParser < Minitest::Test
  def test_parsing_simple_line
    input = '/help_page/1 126.318.035.038'
    parsed = LineParser.new(input).call
    expected = Line.new(path: '/help_page/1', ip: '126.318.035.038')
    assert_equal expected, parsed
  end

  def test_parsing_line_with_whitespaces
    input = "    /help_page/1 126.318.035.038\n"
    parsed = LineParser.new(input).call
    expected = Line.new(path: '/help_page/1', ip: '126.318.035.038')
    assert_equal expected, parsed
  end

  def test_parsing_line_with_3_sections
    input = '/help_page/1 126.318.035.038 404'
    assert_raises LineParser::UnexpectedLineFormatError do
      LineParser.new(input).call
    end
  end
end
