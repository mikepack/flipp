require 'spec_helper'

describe Flipp::Helpers::GitHelper do
  before do
    module Rails; end
    Rails.stub(:root).and_return(File.join(File.dirname(__FILE__), '..', '..', '..', '..'))
  end

  describe '#hook_installed?' do
    it 'returns true when the hook exists' do
      FileUtils.touch '.git/hooks/post-checkout'
      Flipp::Helpers::GitHelper.hook_installed?.should be_true
    end

    it 'returns false when the hook does not exists' do
      FileUtils.rm '.git/hooks/post-checkout'
      Flipp::Helpers::GitHelper.hook_installed?.should be_false
    end
  end

  describe '#install_hook' do
    it 'moves the git hook into place' do
      Flipp::Helpers::GitHelper.install_hook
      FileUtils.compare_file('.git/hooks/post-checkout', File.expand_path('../../../../../lib/flipp/git_hooks/post-checkout', __FILE__))
    end
  end

  describe '#uninstall_hook' do
    before { Flipp::Helpers::GitHelper.install_hook }

    it 'remove the git hook' do
      Flipp::Helpers::GitHelper.uninstall_hook
      Flipp::Helpers::GitHelper.hook_installed?.should be_false
    end
  end

  describe '#current_branch' do
    it 'returns the name of the current git branch' do
      `git checkout -b new_and_fun_branch`
      Flipp::Helpers::GitHelper.current_branch.should == 'new_and_fun_branch'

      # Cleanup
      `git checkout master && git branch -d new_and_fun_branch`
    end
  end
end