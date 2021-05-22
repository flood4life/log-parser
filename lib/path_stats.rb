# frozen_string_literal: true

# @PathStats contains the number of total and unique visits per path.
PathStats = Struct.new(:path, :total, :unique, keyword_init: true)
