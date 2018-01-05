require "mkfiles/extract_yaml"
require "mkfiles/absolutize_paths"
require "mkfiles/create_entries"

module Mkfiles

  def self.generate_from_file(filename)
    conf = self.extract_yaml(filename)
    self.create_entries(
      self.absolutize_paths(conf.start_place, conf.sub_paths)
    )
  end
  
end
