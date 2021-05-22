# frozen_string_literal: true

# @Line represents a single line in the webserver log.
Line = Struct.new(:path, :ip, keyword_init: true)
