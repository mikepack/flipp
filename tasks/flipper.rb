require File.join(File.dirname(__FILE__), '../lib/helpers/git_helper')

namespace :flipper do
  desc 'Install flipper'
  task :install do
    # Move git hook into place
    GitHelper.install_hook
    
    # Move Rails database switch to initializers
  end

  desc 'Uninstall flipper'
  task :uninstall do
    # Remove git hook
    
    # Remove Rails initializer
  end
end