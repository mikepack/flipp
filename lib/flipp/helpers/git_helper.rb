require 'fileutils'

module Flipp
  module Helpers
    module GitHelper
      def self.hook_installed?
        File.exists? File.join(Rails.root, '.git/hooks/post-checkout')
      end

      def self.install_hook
        # Check for the .git directory
        if File.directory? '.git'
          unless File.directory? '.git/hooks'
            # Create hooks directory
          end

          # Copy the file to the git hooks
          puts 'Moving git hook into place...'
          FileUtils.cp File.join(::Flipp.root, 'git_hooks', 'post-checkout'), File.join(Rails.root, '.git/hooks/post-checkout')
          # And give it execute permissions
          FileUtils.chmod 0755, '.git/hooks/post-checkout'
        else
          puts "Can't find your .git directory. Are you at the root of your project?"
        end
      end

      def self.uninstall_hook
        puts 'Removing git hook...'
        FileUtils.rm File.join(Rails.root, '.git/hooks/post-checkout')
      end

      def self.current_branch
        `git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* /\1/'`.chomp[1..-1] # Remove control character
      end
    end
  end
end