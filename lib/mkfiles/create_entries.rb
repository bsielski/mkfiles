require 'fileutils'
require 'pathname'
require 'mkfiles/create_file'
require 'mkfiles/create_directory'


module Mkfiles

  def self.create_entries(abs_paths)

    abs_paths.each do |path|
      self.create_file(path) if path[-1] != "/"
      self.create_directory(path.chop) if path[-1] == "/"
    end

  end

end
