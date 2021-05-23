# frozen_string_literal: true

require_relative './path_stats'

# @StatsSorter provides convenience methods
# to sort an array of @PathStats by total and by unique views.
class StatsSorter
  def initialize(stats)
    @stats = stats
  end

  def by_total
    stats.sort_by(&:total).reverse
  end

  def by_unique
    stats.sort_by(&:unique).reverse
  end

  private

  attr_reader :stats
end
