require "optparse"

module Mkfiles

  def self.parse_options(cli_args)
    args = cli_args.slice(0..-1)
    args << "-h" if args.empty?
    options = {}
    parser = OptionParser.new do |opts|
      opts.on("-h", "--help") do
        options[:help] = true
      end
      opts.on("-g", "--generate") do
        options[:generate_yaml] = true
      end

    end

    parser.parse!(args)

    unless options[:help] == true
      options[:files] = args
    end

    return options
  end
  
end
