# frozen_string_literal: true

require_relative './line'
require_relative './path_stats'

# @VisitsCounter aggregates the number of total and unique visits per page,
# and can provide its current state at any moment.
class VisitsCounter
  def initialize
    @stats = Hash.new { |hash, key| hash[key] = new_path_stats(path: key) }
  end

  # @record accepts a @Line and updates the aggregated stats. If successful, returns +nil+.
  def record(line)
    raise ArgumentError, "expected a Line but got #{line.class}" unless line.is_a?(Line)

    stat = @stats[line.path]
    stat.total += 1
    stat.unique_ips << line.ip

    nil
  end

  # @stats returns an array of @PathStats.
  def stats
    @stats.values.map do |stat|
      PathStats.new(path: stat.path, total: stat.total, unique: stat.unique_ips.size)
    end
  end

  private

  PrivatePathStats = Struct.new(:path, :total, :unique_ips, keyword_init: true)

  def new_path_stats(path:)
    PrivatePathStats.new(path: path, total: 0, unique_ips: Set.new)
  end
end
