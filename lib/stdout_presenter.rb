# frozen_string_literal: true

require_relative './stats_sorter'

# @StdoutPresenter provides convenience methods to
# build string representation of stats suitable for
# printing to STDOUT.
class StdoutPresenter
  # expects an array of @PathStats.
  def initialize(stats)
    @sorter = StatsSorter.new(stats)
  end

  def total
    @sorter.by_total.map { |stat| "#{stat.path} #{stat.total}" }.join("\n")
  end

  def unique
    @sorter.by_unique.map { |stat| "#{stat.path} #{stat.unique}" }.join("\n")
  end
end
