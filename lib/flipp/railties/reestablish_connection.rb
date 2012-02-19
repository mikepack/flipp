require 'flipp'

class ReestablishConnection < Rails::Railtie
  initializer "restablish_connection.configure_rails_initialization" do
    if Rails.env.development? and GitHelper.hook_installed?
      # Use the connection determined by flipp
      flipp = Flipp.new
      flipp.switch_databases
    end
  end
end