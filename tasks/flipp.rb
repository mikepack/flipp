require File.join(File.dirname(__FILE__), '../lib/helpers/git_helper')

namespace :flipp do
  desc 'Install flipp'
  task :install do
    # Move git hook into place
    GitHelper.install_hook
  end

  desc 'Uninstall flipp'
  task :uninstall do
    # Remove git hook
    GitHelper.uninstall_hook
  end
end