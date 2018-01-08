require "optparse"

module Mkfiles

  def self.parse_options(cli_args)
    
    args = cli_args.slice(0..-1)
    args << "-h" if args.empty?
    options = {}
    files = true
    parser = OptionParser.new do |opts|
      opts.on("-h", "--help") do
        options[:help] = true
        files = false
      end
      opts.on("-v", "--version") do
        options[:version] = true
        files = false
      end
      opts.on("-g", "--generate=PATH_TO_FILE") do |path|
        options[:generate_yaml] = path
        files = false
      end
    end

    parser.parse!(args)

    if files == true
      options[:files] = args
    end

    return options
    
  end
  
end
