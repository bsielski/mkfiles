module Mkfiles
  
  def self.cli_application(options)
    if options[:version] == true
      puts "Mkfiles version #{Mkfiles::VERSION}"
    end

  end
  
end
