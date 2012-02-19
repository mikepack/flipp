require 'rubygems'
require 'active_record'
require 'database_exporter'
require File.join(File.dirname(__FILE__), '../helpers/git_helper')

# The Flipp class orchestrates the actual switching of databaseses
class Flipp
  def initialize(branch = GitHelper.current_branch)
    @branch = branch
  end

  def switch_databases
    current_config = ActiveRecord::Base.connection_pool.spec.config  
    new_config = current_config.merge!({:database => new_database_name(current_config)})

    puts "Switching databases (#{new_config[:database]})..."

    # Try connecting to the new database
    begin
      ActiveRecord::Base.establish_connection new_config
    rescue
      create_new_db_or_fallback current_config, new_config
    end
  end

  def create_new_db_or_fallback(current_config, new_config)
    # Try creating then connecting to the new database
    begin
      create_and_copy_data! current_config, new_config
    rescue => exception
      # Fallback and use the original config
      puts "Could not use the new database, falling back to your normal development database..."
      ActiveRecord::Base.establish_connection current_config
    end
  end

  def new_database_name(config)
    # The new name for the database
    # eg. if the original dev database is dev_db and the branch was "new_feature",
    #     the new database would be db_db_new_feature
    config[:database] + '_' + @branch
  end

  def create_and_copy_data!(current_config, new_config)
    # Copy the current development database's data to the new database
    puts "Copying data to the new database (this could take a minute but will only run once)..."
    copy_data current_config, new_config

    # Try out the new database
    ActiveRecord::Base.establish_connection new_config
  end

  def copy_data(current_config, new_config)
    DatabaseExporter.new(current_config).copy(new_config)
  end
end