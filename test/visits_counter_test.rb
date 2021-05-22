# frozen_string_literal: true

require 'minitest/autorun'

require_relative '../lib/visits_counter'

class TestVisitsCounter < Minitest::Test
  def test_record_single_visit
    counter = VisitsCounter.new
    lines = [
      Line.new(path: '/foo', ip: '127.0.0.1')
    ]

    lines.each { counter.record(_1) }

    stats = counter.stats
    expected_stats = [PathStats.new(path: '/foo', total: 1, unique: 1)]

    assert_equal stats, expected_stats
  end

  def test_record_two_visits_from_same_ip
    counter = VisitsCounter.new
    lines = [
      Line.new(path: '/foo', ip: '127.0.0.1'),
      Line.new(path: '/foo', ip: '127.0.0.1')
    ]

    lines.each { counter.record(_1) }

    stats = counter.stats
    expected_stats = [PathStats.new(path: '/foo', total: 2, unique: 1)]

    assert_equal stats, expected_stats
  end
end
