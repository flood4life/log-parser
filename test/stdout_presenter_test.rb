# frozen_string_literal: true

require 'minitest/autorun'

require_relative '../lib/stdout_presenter'

class TestStdoutPresenter < Minitest::Test
  def test_presenting_total_views
    stats = [
      PathStats.new(path: '/foo', total: 5, unique: 1),
      PathStats.new(path: '/bar', total: 10, unique: 1)
    ]
    expected = "/bar 10\n/foo 5"

    assert_equal expected, StdoutPresenter.new(stats).total
  end

  def test_presenting_unique_views
    stats = [
      PathStats.new(path: '/foo', total: 5, unique: 1),
      PathStats.new(path: '/bar', total: 10, unique: 4)
    ]
    expected = "/bar 4\n/foo 1"

    assert_equal expected, StdoutPresenter.new(stats).unique
  end
end
