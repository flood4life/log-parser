# frozen_string_literal: true

require 'minitest/autorun'

require_relative '../lib/stats_sorter'

class TestStatsSorter < Minitest::Test
  def test_single_stat_by_total
    stats = [
      PathStats.new(path: '/foo', total: 1, unique: 1)
    ]
    expected = [
      PathStats.new(path: '/foo', total: 1, unique: 1)
    ]

    assert_equal expected, StatsSorter.new(stats).by_total
  end

  def test_two_stats_by_total
    stats = [
      PathStats.new(path: '/foo', total: 2, unique: 2),
      PathStats.new(path: '/bar', total: 3, unique: 1)
    ]
    expected = [
      PathStats.new(path: '/bar', total: 3, unique: 1),
      PathStats.new(path: '/foo', total: 2, unique: 2)
    ]

    assert_equal expected, StatsSorter.new(stats).by_total
  end

  def test_single_stat_by_unique
    stats = [
      PathStats.new(path: '/foo', total: 1, unique: 1)
    ]
    expected = [
      PathStats.new(path: '/foo', total: 1, unique: 1)
    ]

    assert_equal expected, StatsSorter.new(stats).by_unique
  end

  def test_two_stats_by_unique
    stats = [
      PathStats.new(path: '/bar', total: 3, unique: 1),
      PathStats.new(path: '/foo', total: 2, unique: 2)
    ]
    expected = [
      PathStats.new(path: '/foo', total: 2, unique: 2),
      PathStats.new(path: '/bar', total: 3, unique: 1)
    ]

    assert_equal expected, StatsSorter.new(stats).by_unique
  end
end
