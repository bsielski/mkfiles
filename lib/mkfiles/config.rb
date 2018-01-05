module Mkfiles

  class Config

    attr_reader :start_place, :sub_paths

    def initialize(yaml_hash)
      @start_place = yaml_hash["start_place"]
      @sub_paths = yaml_hash["sub_paths"]
    end
    
  end
  
end
