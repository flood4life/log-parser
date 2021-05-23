# frozen_string_literal: true

require 'minitest/autorun'

require_relative '../lib/visits_counter'

class TestVisitsCounter < Minitest::Test
  def test_record_single_visit
    lines = [
      Line.new(path: '/foo', ip: '127.0.0.1')
    ]
    stats = [
      PathStats.new(path: '/foo', total: 1, unique: 1)
    ]

    assert_lines_and_stats(lines, stats)
  end

  def test_record_two_visits_from_same_ip
    lines = [
      Line.new(path: '/foo', ip: '127.0.0.1'),
      Line.new(path: '/foo', ip: '127.0.0.1')
    ]
    stats = [
      PathStats.new(path: '/foo', total: 2, unique: 1)
    ]

    assert_lines_and_stats(lines, stats)
  end

  def test_record_two_visits_from_different_ips
    lines = [
      Line.new(path: '/foo', ip: '127.0.0.1'),
      Line.new(path: '/foo', ip: '192.168.1.1')
    ]
    stats = [
      PathStats.new(path: '/foo', total: 2, unique: 2)
    ]

    assert_lines_and_stats(lines, stats)
  end

  def test_record_different_paths_same_ip
    lines = [
      Line.new(path: '/foo', ip: '127.0.0.1'),
      Line.new(path: '/bar', ip: '127.0.0.1')
    ]
    stats = [
      PathStats.new(path: '/foo', total: 1, unique: 1),
      PathStats.new(path: '/bar', total: 1, unique: 1)
    ]

    assert_lines_and_stats(lines, stats)
  end

  private

  def assert_lines_and_stats(lines, expected_stats)
    counter = VisitsCounter.new
    lines.each { counter.record(_1) }

    assert_equal expected_stats, counter.stats
  end
end
