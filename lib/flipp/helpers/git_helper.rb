require 'fileutils'

module Flipp
  module Helpers
    module GitHelper
      def self.current_branch
        `git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* /\1/'`.chomp[1..-1] # Remove control character
      end
    end
  end
end