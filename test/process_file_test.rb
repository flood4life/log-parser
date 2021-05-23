# frozen_string_literal: true

require 'minitest/autorun'

require_relative '../cmd/process_file'

class TestProcessFile < Minitest::Test
  EXPECTED_OUTPUT = <<~EXPECTED
    --- TOP TOTAL VIEWS ---
    /about/2 90
    /contact 89
    /index 82
    /about 81
    /help_page/1 80
    /home 78
    --- END TOP TOTAL VIEWS ---
    --- TOP UNIQUE VIEWS ---
    /index 23
    /home 23
    /contact 23
    /help_page/1 23
    /about/2 22
    /about 21
    --- END TOP UNIQUE VIEWS ---
  EXPECTED

  def test_process_file
    output = ProcessFile.new('data/webserver.log').call
    assert_equal EXPECTED_OUTPUT, output
  end
end
