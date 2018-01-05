require 'yaml'
require "mkfiles/config"

module Mkfiles
  
  def self.extract_yaml(filename)
    yaml = open(filename) do |file|
      YAML.load file.read
    end
    Config.new(yaml)
  end
  
end
