require 'spec_helper'

describe Flipp::Helpers::GitHelper do
  before do
    module Rails; end
    Rails.stub(:root).and_return(File.join(File.dirname(__FILE__), '..', '..', '..', '..'))
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