class Flipper
  def initialize(branch)
    @branch = branch.chomp
  end

  def switch_databases
    puts "Switching databases(#{@branch})..."
  end
end