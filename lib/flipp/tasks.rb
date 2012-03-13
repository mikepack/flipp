require File.join(File.dirname(__FILE__), '..', '..', 'lib/flipp/helpers/git_helper')

namespace :flipp do
  desc 'Install flipp'
  task :install do
    # Move git hook into place
    Flipp::GitHelper.install_hook
  end

  desc 'Uninstall flipp'
  task :uninstall do
    # Remove git hook
    Flipp::GitHelper.uninstall_hook
  end
end