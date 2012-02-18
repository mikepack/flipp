require 'fileutils'

module GitHelper
  def self.install_hook
    # Check for the .git directory
    if File.directory? '.git'
      unless File.directory? '.git/hooks'
        # Create hooks directory
      end

      # Copy the file to the git hooks
      FileUtils.cp 'lib/git_hooks/post-checkout', File.expand_path('.git/hooks/post-checkout')
      # And give it execute permissions
      FileUtils.chmod 0755, '.git/hooks/post-checkout'
    else
      puts "Can't find your .git directory. Are you at the root of your project?"
    end
    
    # Move hook into place
    
  end
end