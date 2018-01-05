require 'fileutils'
require 'pathname'

module Mkfiles

  def self.create_file(abs_path)
    
    path = Pathname.new(abs_path)
    FileUtils.mkdir_p path.dirname
    File.open(abs_path, "w") {|file| }

  end

end
