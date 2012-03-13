require 'flipp'

module Flipp
  class Railtie < Rails::Railtie
    initializer "restablish_connection.configure_rails_initialization" do
      if Rails.env.development? and Flipp::GitHelper.hook_installed?
        # Use the connection determined by flipp
        flipp = Flipp::Flipp.new
        flipp.switch_databases
      end

      rake_tasks do
        load 'flipp/tasks.rb'
      end
    end
  end
end