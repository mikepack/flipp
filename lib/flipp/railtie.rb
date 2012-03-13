require 'flipp'

module Flipp
  class Railtie < Rails::Railtie
    initializer "restablish_connection.configure_rails_initialization" do
      if Rails.env.development?
        # Use the connection determined by flipp
        flipp = ::Flipp::Flipp.new
        flipp.switch_databases
      end
    end
  end
end